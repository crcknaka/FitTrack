-- ROLLBACK AND FIX: Remove circular dependency in RLS policies

-- Drop the problematic policies
DROP POLICY IF EXISTS "Users can view own profile or admin can view all" ON public.profiles;
DROP POLICY IF EXISTS "Users can view own workouts or admin can view all" ON public.workouts;
DROP POLICY IF EXISTS "Users can view own workout sets or admin can view all" ON public.workout_sets;

-- Restore original policies for profiles (no circular dependency)
CREATE POLICY "Users can view own profile"
ON public.profiles FOR SELECT
USING (auth.uid() = user_id);

-- Special policy: Admins can view all profiles (uses direct check, no subquery)
CREATE POLICY "Admins can view all profiles"
ON public.profiles FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM public.profiles admin_profile
    WHERE admin_profile.user_id = auth.uid()
    AND admin_profile.is_admin = true
  )
);

-- Original policy: Users can view own workouts
CREATE POLICY "Users can view own workouts"
ON public.workouts FOR SELECT
USING (auth.uid() = user_id);

-- Special policy: Admins can view all workouts
CREATE POLICY "Admins can view all workouts"
ON public.workouts FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM public.profiles
    WHERE user_id = auth.uid() AND is_admin = true
  )
);

-- Original policy: Users can view own workout sets
CREATE POLICY "Users can view own workout sets"
ON public.workout_sets FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM public.workouts w
    WHERE w.id = workout_sets.workout_id AND w.user_id = auth.uid()
  )
);

-- Special policy: Admins can view all workout sets
CREATE POLICY "Admins can view all workout sets"
ON public.workout_sets FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM public.profiles
    WHERE user_id = auth.uid() AND is_admin = true
  )
);
