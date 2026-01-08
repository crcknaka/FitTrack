-- Step 2: Add preset Plank exercise (only if it doesn't exist)
-- This must be in a separate migration after the enum value is committed
INSERT INTO public.exercises (name, type, is_preset, image_url)
SELECT 'Планка', 'timed'::exercise_type, true, '/exercises/planka.jpg'
WHERE NOT EXISTS (
  SELECT 1 FROM public.exercises WHERE name = 'Планка' AND is_preset = true
);
