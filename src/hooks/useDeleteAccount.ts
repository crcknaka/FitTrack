import { useMutation } from "@tanstack/react-query";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/contexts/AuthContext";

export function useDeleteAccount() {
  const { user, signOut } = useAuth();

  return useMutation({
    mutationFn: async () => {
      if (!user) throw new Error("User not authenticated");

      const userId = user.id;

      // Delete all user data in order (respecting foreign key constraints)

      // 1. Delete workout photos (references workout_sets)
      const { error: photosError } = await supabase
        .from("workout_photos")
        .delete()
        .eq("user_id", userId);
      if (photosError) console.error("Error deleting photos:", photosError);

      // 2. Delete workout sets (references workouts and exercises)
      const { error: setsError } = await supabase
        .from("workout_sets")
        .delete()
        .eq("user_id", userId);
      if (setsError) console.error("Error deleting sets:", setsError);

      // 3. Delete workouts
      const { error: workoutsError } = await supabase
        .from("workouts")
        .delete()
        .eq("user_id", userId);
      if (workoutsError) console.error("Error deleting workouts:", workoutsError);

      // 4. Delete user-created exercises
      const { error: exercisesError } = await supabase
        .from("exercises")
        .delete()
        .eq("created_by", userId);
      if (exercisesError) console.error("Error deleting exercises:", exercisesError);

      // 5. Delete friendships (where user is requester or addressee)
      const { error: friendshipsError } = await supabase
        .from("friendships")
        .delete()
        .or(`requester_id.eq.${userId},addressee_id.eq.${userId}`);
      if (friendshipsError) console.error("Error deleting friendships:", friendshipsError);

      // 6. Delete weight history
      const { error: weightError } = await supabase
        .from("weight_history")
        .delete()
        .eq("user_id", userId);
      if (weightError) console.error("Error deleting weight history:", weightError);

      // 7. Delete profile
      const { error: profileError } = await supabase
        .from("profiles")
        .delete()
        .eq("user_id", userId);
      if (profileError) throw new Error("Failed to delete profile: " + profileError.message);

      // 8. Sign out (this also clears local storage)
      await signOut();

      // Note: The auth user record will be deleted by Supabase's cascade delete
      // or needs to be handled by an edge function with service role key
    },
  });
}
