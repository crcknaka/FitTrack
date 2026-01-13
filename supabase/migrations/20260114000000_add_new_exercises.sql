-- Add new preset exercises: Lateral Raise, Leg Extension, Leg Raises

-- Lateral Raise (weighted)
INSERT INTO public.exercises (name, type, is_preset, image_url, name_translations) VALUES
  ('Разведение гантелей в стороны', 'weighted', true, '/exercises/lateral-raise.jpg', '{
    "en": "Lateral Raise",
    "es": "Elevaciones laterales",
    "pt-BR": "Elevacao lateral",
    "de": "Seitheben",
    "fr": "Elevations laterales"
  }'::jsonb);

-- Leg Extension (weighted)
INSERT INTO public.exercises (name, type, is_preset, image_url, name_translations) VALUES
  ('Разгибание ног в тренажёре', 'weighted', true, '/exercises/leg-extension.jpg', '{
    "en": "Leg Extension",
    "es": "Extension de piernas",
    "pt-BR": "Extensao de pernas",
    "de": "Beinstrecken",
    "fr": "Leg extension"
  }'::jsonb);

-- Leg Raises (bodyweight)
INSERT INTO public.exercises (name, type, is_preset, image_url, name_translations) VALUES
  ('Подъём ног', 'bodyweight', true, '/exercises/leg-raises.jpg', '{
    "en": "Leg Raises",
    "es": "Elevacion de piernas",
    "pt-BR": "Elevacao de pernas",
    "de": "Beinheben",
    "fr": "Releves de jambes"
  }'::jsonb);
