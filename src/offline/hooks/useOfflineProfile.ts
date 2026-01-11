import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";
import { useOffline } from "@/contexts/OfflineContext";
import { offlineDb } from "../db";
import { syncQueue } from "../syncQueue";
import type { OfflineProfile } from "../types";
import type { Profile } from "@/hooks/useProfile";

// Offline-first profile hook
export function useOfflineProfile() {
  const { user } = useAuth();
  const { isOnline, isInitialized } = useOffline();

  return useQuery({
    queryKey: ["profile", user?.id],
    queryFn: async () => {
      if (!user) return null;

      // Try online first if available
      if (isOnline) {
        try {
          const { data, error } = await supabase
            .from("profiles")
            .select("*")
            .eq("user_id", user.id)
            .single();

          if (!error && data) {
            // Cache to IndexedDB
            const offlineProfile: OfflineProfile = {
              ...data,
              _synced: true,
              _lastModified: Date.now(),
            };
            await offlineDb.profiles.put(offlineProfile);
            return data as Profile;
          }
        } catch {
          // Fall through to offline data
        }
      }

      // Fallback to IndexedDB
      const cachedProfile = await offlineDb.profiles.get(user.id);
      if (cachedProfile) {
        // Convert OfflineProfile to Profile (remove offline metadata)
        const { _synced, _lastModified, ...profile } = cachedProfile;
        return profile as Profile;
      }

      return null;
    },
    enabled: !!user && isInitialized,
    staleTime: 1000 * 60 * 5, // 5 minutes
    gcTime: 1000 * 60 * 30, // 30 minutes
  });
}

// Offline-first update profile mutation
export function useOfflineUpdateProfile() {
  const queryClient = useQueryClient();
  const { user } = useAuth();
  const { isOnline } = useOffline();

  return useMutation({
    mutationFn: async (profileData: Partial<Profile>) => {
      if (!user) throw new Error("User not authenticated");

      // Get current profile from cache
      const currentProfile = await offlineDb.profiles.get(user.id);

      const updatedProfile: OfflineProfile = {
        id: currentProfile?.id || user.id,
        user_id: user.id,
        display_name: currentProfile?.display_name || null,
        current_weight: currentProfile?.current_weight || null,
        gender: currentProfile?.gender || null,
        date_of_birth: currentProfile?.date_of_birth || null,
        height: currentProfile?.height || null,
        avatar: currentProfile?.avatar || null,
        is_skuf: currentProfile?.is_skuf ?? null,
        is_admin: currentProfile?.is_admin || false,
        created_at: currentProfile?.created_at || new Date().toISOString(),
        ...profileData,
        _synced: isOnline,
        _lastModified: Date.now(),
      };

      // Save to IndexedDB immediately
      await offlineDb.profiles.put(updatedProfile);

      // If online, sync to server
      if (isOnline) {
        try {
          const { data, error } = await supabase
            .from("profiles")
            .update(profileData)
            .eq("user_id", user.id)
            .select()
            .single();

          if (error) throw error;

          // Update cache with server response
          const syncedProfile: OfflineProfile = {
            ...data,
            _synced: true,
            _lastModified: Date.now(),
          };
          await offlineDb.profiles.put(syncedProfile);

          return data as Profile;
        } catch {
          // Mark as unsynced and queue
          updatedProfile._synced = false;
          await offlineDb.profiles.put(updatedProfile);

          await syncQueue.enqueue("profiles", "update", user.id, {
            ...profileData,
            user_id: user.id,
          });
        }
      } else {
        // Queue for sync when back online
        await syncQueue.enqueue("profiles", "update", user.id, {
          ...profileData,
          user_id: user.id,
        });
      }

      // Return the updated profile from cache
      const { _synced, _lastModified, ...profile } = updatedProfile;
      return profile as Profile;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["profile"] });
    },
  });
}
