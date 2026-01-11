import Dexie, { type Table } from "dexie";
import type {
  OfflineWorkout,
  OfflineWorkoutSet,
  OfflineExercise,
  OfflineProfile,
  OfflineFavoriteExercise,
  SyncQueueItem,
  SyncMetadata,
} from "./types";

class FitTrackOfflineDB extends Dexie {
  workouts!: Table<OfflineWorkout>;
  workoutSets!: Table<OfflineWorkoutSet>;
  exercises!: Table<OfflineExercise>;
  profiles!: Table<OfflineProfile>;
  favoriteExercises!: Table<OfflineFavoriteExercise>;
  syncQueue!: Table<SyncQueueItem>;
  metadata!: Table<SyncMetadata>;

  constructor() {
    super("FitTrackOfflineDB");

    this.version(1).stores({
      workouts: "id, user_id, date, _synced, _lastModified",
      workoutSets: "id, workout_id, exercise_id, _synced, _lastModified",
      exercises: "id, user_id, is_preset, type, _synced",
      profiles: "user_id",
      favoriteExercises: "id, user_id, exercise_id, _synced",
      syncQueue: "++id, table, createdAt, entityId",
      metadata: "key",
    });
  }
}

export const offlineDb = new FitTrackOfflineDB();

// Helper to generate offline IDs
export function generateOfflineId(): string {
  return `offline_${crypto.randomUUID()}`;
}

// Check if an ID is an offline-generated ID
export function isOfflineId(id: string): boolean {
  return id.startsWith("offline_");
}

// Clear all offline data (useful for logout)
export async function clearOfflineData(): Promise<void> {
  await offlineDb.transaction(
    "rw",
    [
      offlineDb.workouts,
      offlineDb.workoutSets,
      offlineDb.exercises,
      offlineDb.profiles,
      offlineDb.favoriteExercises,
      offlineDb.syncQueue,
      offlineDb.metadata,
    ],
    async () => {
      await offlineDb.workouts.clear();
      await offlineDb.workoutSets.clear();
      await offlineDb.exercises.clear();
      await offlineDb.profiles.clear();
      await offlineDb.favoriteExercises.clear();
      await offlineDb.syncQueue.clear();
      await offlineDb.metadata.clear();
    }
  );
}

// Get last sync timestamp for a table
export async function getLastSyncTime(table: string): Promise<number | null> {
  const meta = await offlineDb.metadata.get(`lastSync_${table}`);
  return meta ? (meta.value as number) : null;
}

// Set last sync timestamp for a table
export async function setLastSyncTime(
  table: string,
  timestamp: number
): Promise<void> {
  await offlineDb.metadata.put({
    key: `lastSync_${table}`,
    value: timestamp,
  });
}
