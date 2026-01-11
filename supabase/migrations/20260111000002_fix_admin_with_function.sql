-- COMPLETE ROLLBACK AND PROPER FIX

-- 1. Drop all policies
DROP POLICY IF EXISTS "Users can view own profile or admin can view all" ON public.profiles;
DROP POLICY IF EXISTS "Users can view own profile" ON public.profiles;
DROP POLICY IF EXISTS "Admins can view all profiles" ON public.profiles;

DROP POLICY IF EXISTS "Users can view own workouts or admin can view all" ON public.workouts;
DROP POLICY IF EXISTS "Users can view own workouts" ON public.workouts;
DROP POLICY IF EXISTS "Admins can view all workouts" ON public.workouts;

DROP POLICY IF EXISTS "Users can view own workout sets or admin can view all" ON public.workout_sets;
DROP POLICY IF EXISTS "Users can view own workout sets" ON public.workout_sets;
DROP POLICY IF EXISTS "Admins can view all workout sets" ON public.workout_sets;

-- 2. Create a SECURITY DEFINER function to check admin status (avoids RLS recursion)
CREATE OR REPLACE FUNCTION public.is_admin(user_uuid UUID)
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT COALESCE(
    (SELECT is_admin FROM public.profiles WHERE user_id = user_uuid LIMIT 1),
    false
  );
$$;

-- 3. Create new policies using the function

-- Profiles policies
CREATE POLICY "Users can view own profile"
ON public.profiles FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Admins can view all profiles"
ON public.profiles FOR SELECT
USING (public.is_admin(auth.uid()));

-- Workouts policies
CREATE POLICY "Users can view own workouts"
ON public.workouts FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Admins can view all workouts"
ON public.workouts FOR SELECT
USING (public.is_admin(auth.uid()));

-- Workout sets policies
CREATE POLICY "Users can view own workout sets"
ON public.workout_sets FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM public.workouts w
    WHERE w.id = workout_sets.workout_id AND w.user_id = auth.uid()
  )
);

CREATE POLICY "Admins can view all workout sets"
ON public.workout_sets FOR SELECT
USING (public.is_admin(auth.uid()));
