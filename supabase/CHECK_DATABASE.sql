-- ============================================
-- ПРОВЕРКА СТРУКТУРЫ БАЗЫ ДАННЫХ
-- ============================================
-- Выполните этот скрипт, чтобы проверить текущее состояние БД

-- 1. Проверка типов упражнений (должно быть: bodyweight, weighted, cardio, timed)
SELECT
  typname as enum_name,
  e.enumlabel as enum_value,
  e.enumsortorder as sort_order
FROM pg_type t
JOIN pg_enum e ON t.oid = e.enumtypid
WHERE typname = 'exercise_type'
ORDER BY e.enumsortorder;

-- 2. Проверка столбцов таблицы workout_sets
-- Должны быть: reps, weight, distance_km, duration_minutes (все nullable)
SELECT
  column_name,
  data_type,
  is_nullable,
  column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'workout_sets'
ORDER BY ordinal_position;

-- 3. Проверка упражнения "Планка"
SELECT
  id,
  name,
  type,
  is_preset,
  image_url,
  created_at
FROM public.exercises
WHERE name = 'Планка';

-- 4. Список всех preset упражнений
SELECT
  name,
  type,
  image_url
FROM public.exercises
WHERE is_preset = true
ORDER BY type, name;
