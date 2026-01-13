import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { supabase } from "@/integrations/supabase/client";

interface EmptyWorkout {
  id: string;
  date: string;
  user_id: string;
}

interface InactiveUser {
  user_id: string;
  display_name: string | null;
  last_workout_date: string | null;
}

// Get count and list of empty workouts (no exercises)
export function useEmptyWorkouts() {
  return useQuery({
    queryKey: ["admin", "emptyWorkouts"],
    queryFn: async (): Promise<EmptyWorkout[]> => {
      // Get all workouts
      const { data: workouts } = await supabase
        .from("workouts")
        .select("id, date, user_id");

      if (!workouts || workouts.length === 0) return [];

      // Get workout IDs that have exercises
      const { data: exerciseData } = await supabase
        .from("workout_exercises")
        .select("workout_id");

      const workoutsWithExercises = new Set(
        exerciseData?.map((e) => e.workout_id) || []
      );

      // Filter to only empty workouts
      return workouts.filter((w) => !workoutsWithExercises.has(w.id));
    },
  });
}

// Delete empty workouts
export function useDeleteEmptyWorkouts() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (workoutIds: string[]): Promise<number> => {
      if (workoutIds.length === 0) return 0;

      const { error } = await supabase
        .from("workouts")
        .delete()
        .in("id", workoutIds);

      if (error) throw error;
      return workoutIds.length;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["admin"] });
      queryClient.invalidateQueries({ queryKey: ["workouts"] });
    },
  });
}

// Get inactive users (no workouts in X days)
export function useInactiveUsers(days: number = 30) {
  return useQuery({
    queryKey: ["admin", "inactiveUsers", days],
    queryFn: async (): Promise<InactiveUser[]> => {
      const cutoffDate = new Date(
        Date.now() - days * 24 * 60 * 60 * 1000
      ).toISOString();

      // Get all profiles
      const { data: profiles } = await supabase
        .from("profiles")
        .select("user_id, display_name");

      if (!profiles) return [];

      // Get last workout date for each user
      const { data: workouts } = await supabase
        .from("workouts")
        .select("user_id, date")
        .order("date", { ascending: false });

      const lastWorkoutMap = new Map<string, string>();
      workouts?.forEach((w) => {
        if (!lastWorkoutMap.has(w.user_id)) {
          lastWorkoutMap.set(w.user_id, w.date);
        }
      });

      // Filter to inactive users
      return profiles
        .map((p) => ({
          user_id: p.user_id,
          display_name: p.display_name,
          last_workout_date: lastWorkoutMap.get(p.user_id) || null,
        }))
        .filter((u) => {
          if (!u.last_workout_date) return true; // Never had a workout
          return u.last_workout_date < cutoffDate;
        });
    },
  });
}

// Get orphaned workout exercises (exercises without valid workout)
export function useOrphanedExercises() {
  return useQuery({
    queryKey: ["admin", "orphanedExercises"],
    queryFn: async (): Promise<number> => {
      // Get all workout IDs
      const { data: workouts } = await supabase
        .from("workouts")
        .select("id");

      const validWorkoutIds = new Set(workouts?.map((w) => w.id) || []);

      // Get all workout exercises
      const { data: exercises } = await supabase
        .from("workout_exercises")
        .select("id, workout_id");

      if (!exercises) return 0;

      // Count orphaned exercises
      return exercises.filter((e) => !validWorkoutIds.has(e.workout_id)).length;
    },
  });
}

// Delete orphaned workout exercises
export function useDeleteOrphanedExercises() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (): Promise<number> => {
      // Get all workout IDs
      const { data: workouts } = await supabase
        .from("workouts")
        .select("id");

      const validWorkoutIds = new Set(workouts?.map((w) => w.id) || []);

      // Get all workout exercises
      const { data: exercises } = await supabase
        .from("workout_exercises")
        .select("id, workout_id");

      if (!exercises) return 0;

      // Find orphaned exercise IDs
      const orphanedIds = exercises
        .filter((e) => !validWorkoutIds.has(e.workout_id))
        .map((e) => e.id);

      if (orphanedIds.length === 0) return 0;

      const { error } = await supabase
        .from("workout_exercises")
        .delete()
        .in("id", orphanedIds);

      if (error) throw error;
      return orphanedIds.length;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["admin"] });
    },
  });
}
