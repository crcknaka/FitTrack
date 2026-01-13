import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";
import { offlineDb } from "../db";
import { syncQueue } from "../syncQueue";
import type { OfflineProfile } from "../types";
import type { Profile } from "@/hooks/useProfile";

// Offline-first profile hook
export function useOfflineProfile() {
  const { user } = useAuth();

  return useQuery({
    queryKey: ["profile", user?.id],
    queryFn: async () => {
      if (!user) return null;

      // Always try cache first for instant display
      const cachedProfile = await offlineDb.profiles.get(user.id);

      // If online, try to refresh from server
      if (navigator.onLine) {
        try {
          const { data, error } = await supabase
            .from("profiles")
            .select("*")
            .eq("user_id", user.id)
            .single();

          if (!error && data) {
            // Update cache
            const offlineProfile: OfflineProfile = {
              ...data,
              _synced: true,
              _lastModified: Date.now(),
            };
            await offlineDb.profiles.put(offlineProfile);
            return data as Profile;
          }
        } catch {
          // Network error - fall through to cached data
        }
      }

      // Return cached data
      if (cachedProfile) {
        const { _synced, _lastModified, ...profile } = cachedProfile;
        return profile as Profile;
      }

      return null;
    },
    enabled: !!user,
    staleTime: 1000 * 60 * 5, // 5 minutes
    gcTime: 1000 * 60 * 30, // 30 minutes
  });
}

// Offline-first update profile mutation
export function useOfflineUpdateProfile() {
  const queryClient = useQueryClient();
  const { user } = useAuth();

  return useMutation({
    mutationFn: async (profileData: Partial<Profile>) => {
      if (!user) throw new Error("User not authenticated");

      // Get current profile from cache
      const currentProfile = await offlineDb.profiles.get(user.id);

      // Use navigator.onLine directly for most accurate online status
      const online = navigator.onLine;

      const updatedProfile: OfflineProfile = {
        id: currentProfile?.id || user.id,
        user_id: user.id,
        display_name: currentProfile?.display_name || null,
        current_weight: currentProfile?.current_weight || null,
        gender: currentProfile?.gender || null,
        date_of_birth: currentProfile?.date_of_birth || null,
        height: currentProfile?.height || null,
        avatar: currentProfile?.avatar || null,
        is_admin: currentProfile?.is_admin || false,
        created_at: currentProfile?.created_at || new Date().toISOString(),
        ...profileData,
        _synced: false, // Will be set to true after successful sync
        _lastModified: Date.now(),
      };

      // Save to IndexedDB immediately (optimistic update)
      await offlineDb.profiles.put(updatedProfile);

      // If online, try to sync to server
      if (online) {
        try {
          const { data, error } = await supabase
            .from("profiles")
            .update(profileData)
            .eq("user_id", user.id)
            .select()
            .single();

          if (!error && data) {
            // Update cache with server response
            const syncedProfile: OfflineProfile = {
              ...data,
              _synced: true,
              _lastModified: Date.now(),
            };
            await offlineDb.profiles.put(syncedProfile);
            return data as Profile;
          }
        } catch {
          // Network error - already saved locally, queue for sync
        }
      }

      // Queue for sync when back online (if not already synced)
      await syncQueue.enqueue("profiles", "update", user.id, {
        ...profileData,
        user_id: user.id,
      });

      // Return the updated profile from cache
      const { _synced, _lastModified, ...profile } = updatedProfile;
      return profile as Profile;
    },
    onSuccess: (data) => {
      // Update query cache directly instead of invalidating (prevents form reset)
      queryClient.setQueryData(["profile", data.user_id], data);
    },
  });
}
