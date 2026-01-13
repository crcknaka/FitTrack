-- Drop is_skuf column from profiles table
-- This column was used for a joke feature and is no longer needed

ALTER TABLE public.profiles DROP COLUMN IF EXISTS is_skuf;
