-- Change is_skuf from BOOLEAN to INTEGER (0-4)
-- 0 = Нормис, 1 = Дерзкий, 2 = Качок, 3 = Скуф, 4 = Альфа-Скуф

-- Step 1: Add new temporary column with integer type
ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS is_skuf_new INTEGER;

-- Step 2: Migrate existing data from boolean to integer
-- Convert true -> 4, false/null -> 0
UPDATE public.profiles
SET is_skuf_new = CASE 
  WHEN is_skuf = true THEN 4
  ELSE 0
END
WHERE is_skuf_new IS NULL;

-- Step 3: Set default value for new column
ALTER TABLE public.profiles
ALTER COLUMN is_skuf_new SET DEFAULT 0;

-- Step 4: Set any remaining NULL values to 0 (for safety)
UPDATE public.profiles
SET is_skuf_new = 0
WHERE is_skuf_new IS NULL;

-- Step 5: Make column NOT NULL
ALTER TABLE public.profiles
ALTER COLUMN is_skuf_new SET NOT NULL;

-- Step 6: Drop old boolean column (if it exists)
ALTER TABLE public.profiles
DROP COLUMN IF EXISTS is_skuf;

-- Step 7: Rename new column to is_skuf
ALTER TABLE public.profiles
RENAME COLUMN is_skuf_new TO is_skuf;

-- Step 8: Add CHECK constraint to ensure values are 0-4
ALTER TABLE public.profiles
DROP CONSTRAINT IF EXISTS is_skuf_check;
ALTER TABLE public.profiles
ADD CONSTRAINT is_skuf_check CHECK (is_skuf >= 0 AND is_skuf <= 4);

