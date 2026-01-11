-- Fix remaining RLS performance issues
-- 1. Optimize "Public read access via share token" policies that still use unoptimized auth.uid()
-- 2. Remove redundant permissive policies on exercises table

-- ============================================================================
-- WORKOUTS TABLE - Fix share token policy
-- ============================================================================

DROP POLICY IF EXISTS "Public read access via share token" ON public.workouts;

CREATE POLICY "Public read access via share token"
ON public.workouts FOR SELECT
USING (
  (((SELECT auth.uid()) IS NOT NULL) AND ((SELECT auth.uid()) = user_id))
  OR (EXISTS (
    SELECT 1 FROM public.workout_shares
    WHERE workout_shares.workout_id = workouts.id
    AND workout_shares.is_active = true
  ))
);

-- ============================================================================
-- WORKOUT_SETS TABLE - Fix share token policy
-- ============================================================================

DROP POLICY IF EXISTS "Public read sets via share token" ON public.workout_sets;

CREATE POLICY "Public read sets via share token"
ON public.workout_sets FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM public.workouts
    WHERE workouts.id = workout_sets.workout_id
    AND (
      (((SELECT auth.uid()) IS NOT NULL) AND (workouts.user_id = (SELECT auth.uid())))
      OR (EXISTS (
        SELECT 1 FROM public.workout_shares
        WHERE workout_shares.workout_id = workouts.id
        AND workout_shares.is_active = true
      ))
    )
  )
);

-- ============================================================================
-- EXERCISES TABLE - Remove redundant policies
-- Having "Public read access to exercises" (USING true) makes other SELECT policies redundant
-- Keep only "Public read access to exercises" for SELECT since exercises should be publicly readable
-- ============================================================================

DROP POLICY IF EXISTS "Users can view preset and own exercises" ON public.exercises;

-- Note: "Public read access to exercises" already exists with USING (true)
-- This covers all read access, so we don't need the preset/own exercises policy
