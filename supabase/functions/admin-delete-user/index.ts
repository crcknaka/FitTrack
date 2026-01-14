import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    // Get the authorization header
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      return new Response(
        JSON.stringify({ error: "No authorization header" }),
        { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Get the target user ID from request body
    const { userId: targetUserId } = await req.json();
    if (!targetUserId) {
      return new Response(
        JSON.stringify({ error: "userId is required" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Create Supabase clients
    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const supabaseAnonKey = Deno.env.get("SUPABASE_ANON_KEY")!;
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

    // Client with user's auth to verify they are admin
    const supabaseClient = createClient(supabaseUrl, supabaseAnonKey, {
      global: { headers: { Authorization: authHeader } },
    });

    // Get the requesting user from the JWT
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser();

    if (userError || !user) {
      return new Response(
        JSON.stringify({ error: "Invalid token or user not found" }),
        { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Admin client with service role key
    const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey, {
      auth: {
        autoRefreshToken: false,
        persistSession: false,
      },
    });

    // Verify the requesting user is an admin
    const { data: adminProfile, error: profileError } = await supabaseAdmin
      .from("profiles")
      .select("is_admin")
      .eq("user_id", user.id)
      .single();

    if (profileError || !adminProfile?.is_admin) {
      return new Response(
        JSON.stringify({ error: "Unauthorized: Admin access required" }),
        { status: 403, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Prevent admin from deleting themselves
    if (targetUserId === user.id) {
      return new Response(
        JSON.stringify({ error: "Cannot delete your own account via admin panel" }),
        { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // Delete all user data (in order respecting foreign key constraints)

    // 1. Delete workout shares
    await supabaseAdmin
      .from("workout_shares")
      .delete()
      .eq("user_id", targetUserId);

    // 2. Delete favorite exercises
    await supabaseAdmin
      .from("favorite_exercises")
      .delete()
      .eq("user_id", targetUserId);

    // 3. Get all workout IDs for this user
    const { data: workouts } = await supabaseAdmin
      .from("workouts")
      .select("id")
      .eq("user_id", targetUserId);

    const workoutIds = workouts?.map(w => w.id) || [];

    // 4. Delete workout sets for user's workouts
    if (workoutIds.length > 0) {
      await supabaseAdmin
        .from("workout_sets")
        .delete()
        .in("workout_id", workoutIds);
    }

    // 5. Delete workouts
    await supabaseAdmin
      .from("workouts")
      .delete()
      .eq("user_id", targetUserId);

    // 6. Delete user-created exercises
    await supabaseAdmin
      .from("exercises")
      .delete()
      .eq("user_id", targetUserId);

    // 7. Delete friendships (where user is requester or addressee)
    await supabaseAdmin
      .from("friendships")
      .delete()
      .or(`requester_id.eq.${targetUserId},addressee_id.eq.${targetUserId}`);

    // 8. Delete body weight history
    await supabaseAdmin
      .from("body_weight_history")
      .delete()
      .eq("user_id", targetUserId);

    // 9. Delete profile
    await supabaseAdmin
      .from("profiles")
      .delete()
      .eq("user_id", targetUserId);

    // 10. Delete user from auth.users using admin API
    const { error: deleteError } = await supabaseAdmin.auth.admin.deleteUser(targetUserId);

    if (deleteError) {
      console.error("Error deleting auth user:", deleteError);
      return new Response(
        JSON.stringify({ error: "Failed to delete user account: " + deleteError.message }),
        { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    return new Response(
      JSON.stringify({ success: true, message: "User deleted successfully" }),
      { status: 200, headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );

  } catch (error) {
    console.error("Error in admin-delete-user function:", error);
    return new Response(
      JSON.stringify({ error: error.message || "Internal server error" }),
      { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );
  }
});
