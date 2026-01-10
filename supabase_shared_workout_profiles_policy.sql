-- Allow anonymous users to view profiles (needed for shared workouts)
-- Profile information (name, avatar, weight, age) is considered public
CREATE POLICY "Allow anonymous access to view profiles"
ON public.profiles FOR SELECT
TO anon
USING (true);
