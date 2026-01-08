-- Step 1: Add 'timed' value to exercise_type enum
ALTER TYPE exercise_type ADD VALUE IF NOT EXISTS 'timed';
