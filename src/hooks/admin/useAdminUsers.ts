import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { supabase } from "@/integrations/supabase/client";

export interface AdminUser {
  user_id: string;
  display_name: string | null;
  username: string | null;
  avatar: string | null;
  is_admin: boolean;
  created_at: string;
  workout_count: number;
  last_workout_date: string | null;
}

export function useAdminUsers(search: string = "") {
  return useQuery({
    queryKey: ["admin", "users", search],
    queryFn: async (): Promise<AdminUser[]> => {
      // Get all profiles
      let query = supabase
        .from("profiles")
        .select("user_id, display_name, username, avatar, is_admin, created_at");

      if (search) {
        // Search by display_name OR username
        query = query.or(`display_name.ilike.%${search}%,username.ilike.%${search}%`);
      }

      const { data: profiles, error } = await query.order("created_at", {
        ascending: false,
      });

      if (error) throw error;
      if (!profiles) return [];

      // Get workout counts for all users
      const { data: workouts } = await supabase
        .from("workouts")
        .select("user_id, date")
        .order("date", { ascending: false });

      // Build workout stats map
      const workoutStats = new Map<
        string,
        { count: number; lastDate: string | null }
      >();
      workouts?.forEach((w) => {
        const existing = workoutStats.get(w.user_id);
        if (existing) {
          existing.count++;
        } else {
          workoutStats.set(w.user_id, { count: 1, lastDate: w.date });
        }
      });

      return profiles.map((p) => {
        const stats = workoutStats.get(p.user_id);
        return {
          ...p,
          workout_count: stats?.count || 0,
          last_workout_date: stats?.lastDate || null,
        };
      });
    },
  });
}

export function useSetAdminStatus() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async ({
      userId,
      isAdmin,
    }: {
      userId: string;
      isAdmin: boolean;
    }) => {
      const { error } = await supabase
        .from("profiles")
        .update({ is_admin: isAdmin })
        .eq("user_id", userId);

      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["admin", "users"] });
    },
  });
}

export function useDeleteUser() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: async (userId: string) => {
      // Get the current session for authorization
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) throw new Error("No active session");

      // Call the admin-delete-user edge function to properly delete the user
      // This ensures the auth user is also deleted, not just the profile data
      const response = await fetch(
        `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/admin-delete-user`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${session.access_token}`,
          },
          body: JSON.stringify({ userId }),
        }
      );

      const result = await response.json();

      if (!response.ok) {
        throw new Error(result.error || "Failed to delete user");
      }

      return result;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["admin", "users"] });
      queryClient.invalidateQueries({ queryKey: ["admin", "stats"] });
    },
  });
}
