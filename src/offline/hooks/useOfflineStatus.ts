import { useState, useEffect, useCallback } from "react";
import { offlineDb } from "../db";

export interface OfflineStatus {
  isOnline: boolean;
  pendingCount: number;
  lastSyncTime: number | null;
  checkConnection: () => Promise<boolean>;
}

export function useOfflineStatus(): OfflineStatus {
  const [isOnline, setIsOnline] = useState(navigator.onLine);
  const [pendingCount, setPendingCount] = useState(0);
  const [lastSyncTime, setLastSyncTime] = useState<number | null>(null);

  // Check connectivity using navigator.onLine
  // Sync service will handle actual API failures gracefully
  const checkConnection = useCallback(async (): Promise<boolean> => {
    const online = navigator.onLine;
    setIsOnline(online);
    return online;
  }, []);

  // Update pending count from sync queue
  const updatePendingCount = useCallback(async () => {
    try {
      const count = await offlineDb.syncQueue.count();
      setPendingCount(count);
    } catch {
      // Database might not be ready yet
    }
  }, []);

  // Update last sync time from metadata
  const updateLastSyncTime = useCallback(async () => {
    try {
      const meta = await offlineDb.metadata.get("lastSync_workouts");
      if (meta) {
        setLastSyncTime(meta.value as number);
      }
    } catch {
      // Database might not be ready yet
    }
  }, []);

  // Listen for online/offline events
  useEffect(() => {
    const handleOnline = () => {
      setIsOnline(true);
      checkConnection();
    };

    const handleOffline = () => {
      setIsOnline(false);
    };

    window.addEventListener("online", handleOnline);
    window.addEventListener("offline", handleOffline);

    // Initial check
    checkConnection();

    return () => {
      window.removeEventListener("online", handleOnline);
      window.removeEventListener("offline", handleOffline);
    };
  }, [checkConnection]);

  // Poll for pending count changes
  useEffect(() => {
    updatePendingCount();
    updateLastSyncTime();

    const interval = setInterval(() => {
      updatePendingCount();
      updateLastSyncTime();
    }, 2000);

    return () => clearInterval(interval);
  }, [updatePendingCount, updateLastSyncTime]);

  // Periodic connectivity check when online
  useEffect(() => {
    if (!isOnline) return;

    const interval = setInterval(() => {
      checkConnection();
    }, 30000); // Check every 30 seconds

    return () => clearInterval(interval);
  }, [isOnline, checkConnection]);

  return {
    isOnline,
    pendingCount,
    lastSyncTime,
    checkConnection,
  };
}
