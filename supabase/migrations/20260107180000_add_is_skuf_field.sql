-- Add is_skuf field to profiles table
ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS is_skuf BOOLEAN DEFAULT false;
