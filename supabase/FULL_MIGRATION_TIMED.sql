-- ============================================
-- ПОЛНАЯ МИГРАЦИЯ ДЛЯ ДОБАВЛЕНИЯ ТИПА "TIMED"
-- И УПРАЖНЕНИЯ "ПЛАНКА"
-- ============================================
-- Выполните этот скрипт целиком в Supabase SQL Editor

-- ШАГ 1: Добавляем новый тип упражнения 'timed'
ALTER TYPE exercise_type ADD VALUE IF NOT EXISTS 'timed';

-- ШАГ 2: Добавляем упражнение "Планка" (только если его еще нет)
INSERT INTO public.exercises (name, type, is_preset, image_url)
SELECT 'Планка', 'timed'::exercise_type, true, '/exercises/planka.jpg'
WHERE NOT EXISTS (
  SELECT 1 FROM public.exercises WHERE name = 'Планка' AND is_preset = true
);

-- ШАГ 3: Проверяем результаты
-- Проверка типа упражнения
SELECT
  typname as enum_name,
  e.enumlabel as enum_value
FROM pg_type t
JOIN pg_enum e ON t.oid = e.enumtypid
WHERE typname = 'exercise_type'
ORDER BY e.enumsortorder;

-- Проверка упражнения "Планка"
SELECT id, name, type, is_preset, image_url
FROM public.exercises
WHERE name = 'Планка';

-- Информация о структуре таблицы workout_sets
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'workout_sets'
ORDER BY ordinal_position;
