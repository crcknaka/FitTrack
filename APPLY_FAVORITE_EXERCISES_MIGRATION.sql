-- Migration: Add Favorite Exercises Feature
-- Created: 2026-01-10
-- Apply this in Supabase Dashboard > SQL Editor

-- Create favorite_exercises table for many-to-many relationship
CREATE TABLE IF NOT EXISTS favorite_exercises (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES profiles(user_id) ON DELETE CASCADE,
  exercise_id UUID NOT NULL REFERENCES exercises(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, exercise_id)
);

-- Add indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_favorite_exercises_user_id ON favorite_exercises(user_id);
CREATE INDEX IF NOT EXISTS idx_favorite_exercises_exercise_id ON favorite_exercises(exercise_id);

-- Enable RLS
ALTER TABLE favorite_exercises ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist (to avoid errors on re-run)
DROP POLICY IF EXISTS "Users can view their own favorites" ON favorite_exercises;
DROP POLICY IF EXISTS "Users can insert their own favorites" ON favorite_exercises;
DROP POLICY IF EXISTS "Users can delete their own favorites" ON favorite_exercises;

-- Users can only manage their own favorites
CREATE POLICY "Users can view their own favorites"
  ON favorite_exercises FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own favorites"
  ON favorite_exercises FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own favorites"
  ON favorite_exercises FOR DELETE
  USING (auth.uid() = user_id);
c