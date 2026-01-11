-- Remove redundant SELECT policies
-- When a table has a policy with USING (true), other SELECT policies are redundant
-- and cause performance overhead as PostgreSQL evaluates all permissive policies

-- ============================================================================
-- PROFILES TABLE
-- "Public read access to profiles" USING (true) makes all other SELECT redundant
-- ============================================================================

-- Keep: "Public read access to profiles" - covers all SELECT
-- Remove redundant ones:
DROP POLICY IF EXISTS "Users can view own profile" ON public.profiles;
DROP POLICY IF EXISTS "Users can view all profiles for leaderboard" ON public.profiles;
DROP POLICY IF EXISTS "Admins can view all profiles" ON public.profiles;
DROP POLICY IF EXISTS "Friends can view profiles" ON public.profiles;
DROP POLICY IF EXISTS "Allow anonymous access to view profiles" ON public.profiles;

-- ============================================================================
-- WORKOUTS TABLE
-- "Users can view all workouts for leaderboard" USING (true) makes others redundant
-- ============================================================================

-- Keep: "Users can view all workouts for leaderboard" - covers authenticated SELECT
-- Remove redundant ones:
DROP POLICY IF EXISTS "Users can view own workouts" ON public.workouts;
DROP POLICY IF EXISTS "Admins can view all workouts" ON public.workouts;
DROP POLICY IF EXISTS "Friends can view workouts" ON public.workouts;
DROP POLICY IF EXISTS "Public read access via share token" ON public.workouts;

-- ============================================================================
-- WORKOUT_SETS TABLE
-- "Users can view all workout sets for leaderboard" USING (true) makes others redundant
-- ============================================================================

-- Keep: "Users can view all workout sets for leaderboard" - covers authenticated SELECT
-- Remove redundant ones:
DROP POLICY IF EXISTS "Users can view own workout sets" ON public.workout_sets;
DROP POLICY IF EXISTS "Admins can view all workout sets" ON public.workout_sets;
DROP POLICY IF EXISTS "Friends can view workout sets" ON public.workout_sets;
DROP POLICY IF EXISTS "Public read sets via share token" ON public.workout_sets;

-- ============================================================================
-- EXERCISES TABLE
-- "Public read access to exercises" USING (true) already covers all SELECT
-- ============================================================================

-- Already handled in previous migration - no additional policies to remove
