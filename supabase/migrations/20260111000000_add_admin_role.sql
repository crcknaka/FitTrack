-- Add is_admin field to profiles table
ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS is_admin BOOLEAN NOT NULL DEFAULT false;

-- Set admin flag for the admin user
UPDATE public.profiles
SET is_admin = true
WHERE user_id = '52d6f439-65c2-43be-b93b-3bce58744755';

-- Drop existing RLS policies for profiles that need updating
DROP POLICY IF EXISTS "Users can view own profile" ON public.profiles;

-- Create new policy: Users can view own profile OR admin can view all profiles
CREATE POLICY "Users can view own profile or admin can view all"
ON public.profiles FOR SELECT
USING (
  auth.uid() = user_id
  OR
  EXISTS (
    SELECT 1 FROM public.profiles p
    WHERE p.user_id = auth.uid() AND p.is_admin = true
  )
);

-- Drop existing RLS policies for workouts that need updating
DROP POLICY IF EXISTS "Users can view own workouts" ON public.workouts;

-- Create new policy: Users can view own workouts OR admin can view all workouts
CREATE POLICY "Users can view own workouts or admin can view all"
ON public.workouts FOR SELECT
USING (
  auth.uid() = user_id
  OR
  EXISTS (
    SELECT 1 FROM public.profiles p
    WHERE p.user_id = auth.uid() AND p.is_admin = true
  )
);

-- Drop existing RLS policy for workout_sets
DROP POLICY IF EXISTS "Users can view own workout sets" ON public.workout_sets;

-- Create new policy: Users can view sets from own workouts OR admin can view all sets
CREATE POLICY "Users can view own workout sets or admin can view all"
ON public.workout_sets FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM public.workouts w
    WHERE w.id = workout_sets.workout_id AND w.user_id = auth.uid()
  )
  OR
  EXISTS (
    SELECT 1 FROM public.profiles p
    WHERE p.user_id = auth.uid() AND p.is_admin = true
  )
);
