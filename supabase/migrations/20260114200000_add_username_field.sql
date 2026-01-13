-- Add username field to profiles table
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS username TEXT;

-- Create unique index on username (allows NULL values, only enforces uniqueness for non-NULL)
CREATE UNIQUE INDEX IF NOT EXISTS idx_profiles_username_unique ON profiles(username) WHERE username IS NOT NULL;

-- Create index for faster username searches
CREATE INDEX IF NOT EXISTS idx_profiles_username ON profiles(username);

-- Update handle_new_user function to set username from auth metadata
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = 'public'
AS $$
DECLARE
  generated_username TEXT;
BEGIN
  -- Generate username from email if not provided in metadata
  generated_username := COALESCE(
    NEW.raw_user_meta_data->>'username',
    LOWER(REGEXP_REPLACE(SPLIT_PART(NEW.email, '@', 1), '[^a-z0-9_]', '', 'g')) || FLOOR(RANDOM() * 1000)::TEXT
  );

  INSERT INTO public.profiles (user_id, display_name, username)
  VALUES (
    NEW.id,
    NEW.raw_user_meta_data->>'display_name',
    generated_username
  );
  RETURN NEW;
END;
$$;

-- Generate usernames for existing users without one
UPDATE profiles
SET username = LOWER(REGEXP_REPLACE(COALESCE(display_name, 'user'), '[^a-z0-9_]', '', 'g')) || FLOOR(RANDOM() * 10000)::TEXT
WHERE username IS NULL;
