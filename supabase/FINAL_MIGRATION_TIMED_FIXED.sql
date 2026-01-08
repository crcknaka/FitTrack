-- ============================================
-- ПОЛНАЯ МИГРАЦИЯ ДЛЯ ДОБАВЛЕНИЯ ТИПА "TIMED"
-- И УПРАЖНЕНИЯ "ПЛАНКА" (ИСПРАВЛЕННАЯ ВЕРСИЯ)
-- ============================================

-- ШАГ 1: Добавляем новое поле plank_seconds в таблицу workout_sets
ALTER TABLE public.workout_sets
ADD COLUMN IF NOT EXISTS plank_seconds integer;

-- ШАГ 2: Добавляем комментарий для ясности
COMMENT ON COLUMN public.workout_sets.plank_seconds IS 'Время в секундах для упражнений типа timed (например, планка)';

-- ШАГ 3: Добавляем новый тип упражнения 'timed'
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_enum
        WHERE enumlabel = 'timed'
        AND enumtypid = (SELECT oid FROM pg_type WHERE typname = 'exercise_type')
    ) THEN
        ALTER TYPE exercise_type ADD VALUE 'timed';
    END IF;
END $$;

-- ШАГ 4: Добавляем упражнение "Планка" (только если его еще нет)
INSERT INTO public.exercises (name, type, is_preset, image_url)
SELECT 'Планка', 'timed'::exercise_type, true, '/exercises/planka.jpg'
WHERE NOT EXISTS (
  SELECT 1 FROM public.exercises WHERE name = 'Планка' AND is_preset = true
);

-- ============================================
-- ПРОВЕРКА РЕЗУЛЬТАТОВ
-- ============================================

-- Проверка 1: Проверяем что поле plank_seconds добавлено
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'workout_sets' AND column_name = 'plank_seconds';

-- Проверка 2: Проверяем типы упражнений
SELECT enumlabel FROM pg_enum e
JOIN pg_type t ON e.enumtypid = t.oid
WHERE t.typname = 'exercise_type'
ORDER BY enumlabel;

-- Проверка 3: Проверяем упражнение Планка
SELECT id, name, type, is_preset, image_url
FROM exercises
WHERE name = 'Планка';
