import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { supabase } from "@/integrations/supabase/client";

export interface AdminUser {
  user_id: string;
  display_name: string | null;
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
        .select("user_id, display_name, avatar, is_admin, created_at");

      if (search) {
        query = query.ilike("display_name", `%${search}%`);
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
