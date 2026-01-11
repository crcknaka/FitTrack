-- Optimize all RLS policies to prevent per-row re-evaluation of auth.uid()
-- Wrapping auth.uid() in (SELECT ...) causes it to be evaluated once per query instead of per row
-- This significantly improves query performance at scale

-- ============================================================================
-- WORKOUTS TABLE
-- ============================================================================

DROP POLICY IF EXISTS "Users can view own workouts" ON public.workouts;
DROP POLICY IF EXISTS "Users can create own workouts" ON public.workouts;
DROP POLICY IF EXISTS "Users can update own workouts" ON public.workouts;
DROP POLICY IF EXISTS "Users can delete own workouts" ON public.workouts;
DROP POLICY IF EXISTS "Admins can view all workouts" ON public.workouts;
DROP POLICY IF EXISTS "Friends can view workouts" ON public.workouts;

CREATE POLICY "Users can view own workouts"
ON public.workouts FOR SELECT
USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can create own workouts"
ON public.workouts FOR INSERT
WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can update own workouts"
ON public.workouts FOR UPDATE
USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can delete own workouts"
ON public.workouts FOR DELETE
USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Admins can view all workouts"
ON public.workouts FOR SELECT
USING (public.is_admin((SELECT auth.uid())));

CREATE POLICY "Friends can view workouts"
ON public.workouts FOR SELECT
USING (public.are_friends((SELECT auth.uid()), user_id));

-- ============================================================================
-- WORKOUT_SETS TABLE
-- ============================================================================

DROP POLICY IF EXISTS "Users can view own workout sets" ON public.workout_sets;
DROP POLICY IF EXISTS "Users can create sets for own workouts" ON public.workout_sets;
DROP POLICY IF EXISTS "Users can update own workout sets" ON public.workout_sets;
DROP POLICY IF EXISTS "Users can delete own workout sets" ON public.workout_sets;
DROP POLICY IF EXISTS "Admins can view all workout sets" ON public.workout_sets;
DROP POLICY IF EXISTS "Friends can view workout sets" ON public.workout_sets;

CREATE POLICY "Users can view own workout sets"
ON public.workout_sets FOR SELECT
USING (EXISTS (
  SELECT 1 FROM public.workouts w
  WHERE w.id = workout_sets.workout_id AND w.user_id = (SELECT auth.uid())
));

CREATE POLICY "Users can create sets for own workouts"
ON public.workout_sets FOR INSERT
WITH CHECK (EXISTS (
  SELECT 1 FROM public.workouts w
  WHERE w.id = workout_sets.workout_id AND w.user_id = (SELECT auth.uid())
));

CREATE POLICY "Users can update own workout sets"
ON public.workout_sets FOR UPDATE
USING (EXISTS (
  SELECT 1 FROM public.workouts w
  WHERE w.id = workout_sets.workout_id AND w.user_id = (SELECT auth.uid())
));

CREATE POLICY "Users can delete own workout sets"
ON public.workout_sets FOR DELETE
USING (EXISTS (
  SELECT 1 FROM public.workouts w
  WHERE w.id = workout_sets.workout_id AND w.user_id = (SELECT auth.uid())
));

CREATE POLICY "Admins can view all workout sets"
ON public.workout_sets FOR SELECT
USING (public.is_admin((SELECT auth.uid())));

CREATE POLICY "Friends can view workout sets"
ON public.workout_sets FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM public.workouts w
    WHERE w.id = workout_sets.workout_id
    AND public.are_friends((SELECT auth.uid()), w.user_id)
  )
);

-- ============================================================================
-- PROFILES TABLE
-- ============================================================================

DROP POLICY IF EXISTS "Users can view own profile" ON public.profiles;
DROP POLICY IF EXISTS "Users can create own profile" ON public.profiles;
DROP POLICY IF EXISTS "Users can update own profile" ON public.profiles;
DROP POLICY IF EXISTS "Admins can view all profiles" ON public.profiles;
DROP POLICY IF EXISTS "Friends can view profiles" ON public.profiles;

CREATE POLICY "Users can view own profile"
ON public.profiles FOR SELECT
USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can create own profile"
ON public.profiles FOR INSERT
WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can update own profile"
ON public.profiles FOR UPDATE
USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Admins can view all profiles"
ON public.profiles FOR SELECT
USING (public.is_admin((SELECT auth.uid())));

CREATE POLICY "Friends can view profiles"
ON public.profiles FOR SELECT
USING (public.are_friends((SELECT auth.uid()), user_id));

-- ============================================================================
-- BODY_WEIGHT_HISTORY TABLE
-- ============================================================================

DROP POLICY IF EXISTS "Users can view own weight history" ON public.body_weight_history;
DROP POLICY IF EXISTS "Users can create own weight records" ON public.body_weight_history;
DROP POLICY IF EXISTS "Users can update own weight records" ON public.body_weight_history;
DROP POLICY IF EXISTS "Users can delete own weight records" ON public.body_weight_history;

CREATE POLICY "Users can view own weight history"
ON public.body_weight_history FOR SELECT
USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can create own weight records"
ON public.body_weight_history FOR INSERT
WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can update own weight records"
ON public.body_weight_history FOR UPDATE
USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can delete own weight records"
ON public.body_weight_history FOR DELETE
USING ((SELECT auth.uid()) = user_id);

-- ============================================================================
-- FAVORITE_EXERCISES TABLE
-- ============================================================================

DROP POLICY IF EXISTS "Users can view their own favorites" ON public.favorite_exercises;
DROP POLICY IF EXISTS "Users can insert their own favorites" ON public.favorite_exercises;
DROP POLICY IF EXISTS "Users can delete their own favorites" ON public.favorite_exercises;

CREATE POLICY "Users can view their own favorites"
ON public.favorite_exercises FOR SELECT
USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can insert their own favorites"
ON public.favorite_exercises FOR INSERT
WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can delete their own favorites"
ON public.favorite_exercises FOR DELETE
USING ((SELECT auth.uid()) = user_id);

-- ============================================================================
-- FRIENDSHIPS TABLE
-- ============================================================================

DROP POLICY IF EXISTS "Users can view own friendships" ON public.friendships;
DROP POLICY IF EXISTS "Users can send friend requests" ON public.friendships;
DROP POLICY IF EXISTS "Users can respond to friend requests" ON public.friendships;
DROP POLICY IF EXISTS "Users can delete own friendships" ON public.friendships;

CREATE POLICY "Users can view own friendships"
ON public.friendships FOR SELECT
USING ((SELECT auth.uid()) = requester_id OR (SELECT auth.uid()) = addressee_id);

CREATE POLICY "Users can send friend requests"
ON public.friendships FOR INSERT
WITH CHECK ((SELECT auth.uid()) = requester_id);

CREATE POLICY "Users can respond to friend requests"
ON public.friendships FOR UPDATE
USING ((SELECT auth.uid()) = addressee_id)
WITH CHECK ((SELECT auth.uid()) = addressee_id);

CREATE POLICY "Users can delete own friendships"
ON public.friendships FOR DELETE
USING ((SELECT auth.uid()) = requester_id OR (SELECT auth.uid()) = addressee_id);

-- ============================================================================
-- WORKOUT_SHARES TABLE
-- ============================================================================

DROP POLICY IF EXISTS "Users can view their own shares" ON public.workout_shares;
DROP POLICY IF EXISTS "Users can create shares for their workouts" ON public.workout_shares;
DROP POLICY IF EXISTS "Users can update their own shares" ON public.workout_shares;
DROP POLICY IF EXISTS "Users can delete their own shares" ON public.workout_shares;

CREATE POLICY "Users can view their own shares"
ON public.workout_shares FOR SELECT
USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can create shares for their workouts"
ON public.workout_shares FOR INSERT
WITH CHECK (
  (SELECT auth.uid()) = user_id
  AND EXISTS (
    SELECT 1 FROM public.workouts
    WHERE workouts.id = workout_shares.workout_id
    AND workouts.user_id = (SELECT auth.uid())
  )
);

CREATE POLICY "Users can update their own shares"
ON public.workout_shares FOR UPDATE
USING ((SELECT auth.uid()) = user_id)
WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can delete their own shares"
ON public.workout_shares FOR DELETE
USING ((SELECT auth.uid()) = user_id);
