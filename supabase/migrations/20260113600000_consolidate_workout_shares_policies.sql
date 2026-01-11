-- Consolidate workout_shares SELECT policies into one
-- Having multiple permissive SELECT policies causes PostgreSQL to evaluate all of them
-- for each row, which is inefficient

-- Drop both existing SELECT policies
DROP POLICY IF EXISTS "Anyone can read active shares" ON public.workout_shares;
DROP POLICY IF EXISTS "Users can view their own shares" ON public.workout_shares;

-- Create single consolidated SELECT policy
-- Users can see: their own shares OR any active share (for public workout links)
CREATE POLICY "Users can view shares"
ON public.workout_shares FOR SELECT
USING (
  is_active = true
  OR (SELECT auth.uid()) = user_id
);
