import { useQuery } from "@tanstack/react-query";
import { supabase } from "@/integrations/supabase/client";

export interface UserProfile {
  user_id: string;
  display_name: string | null;
  avatar: string | null;
  is_admin: boolean;
}

export function useAllProfiles() {
  return useQuery({
    queryKey: ["profiles", "all"],
    queryFn: async () => {
      const { data, error } = await supabase
        .from("profiles")
        .select("user_id, display_name, avatar")
        .order("display_name", { ascending: true });

      if (error) throw error;
      // Временно возвращаем is_admin как false, пока не применим миграцию
      return (data || []).map(profile => ({ ...profile, is_admin: false })) as UserProfile[];
    },
  });
}
