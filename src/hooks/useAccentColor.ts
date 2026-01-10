import { useEffect, useState } from "react";

export type AccentColor = "coral" | "blue" | "green" | "purple" | "pink" | "teal";

const ACCENT_STORAGE_KEY = "fittrack-accent-color";

export function useAccentColor() {
  // Read initial value from DOM attribute (already set in main.tsx)
  const [accentColor, setAccentColorState] = useState<AccentColor>(() => {
    const currentAccent = document.documentElement.getAttribute("data-accent");
    if (currentAccent && isValidAccent(currentAccent)) {
      return currentAccent as AccentColor;
    }
    return "coral";
  });

  useEffect(() => {
    document.documentElement.setAttribute("data-accent", accentColor);
    localStorage.setItem(ACCENT_STORAGE_KEY, accentColor);
  }, [accentColor]);

  const setAccentColor = (color: AccentColor) => {
    setAccentColorState(color);
  };

  return { accentColor, setAccentColor };
}

function isValidAccent(value: string): value is AccentColor {
  return ["coral", "blue", "green", "purple", "pink", "teal"].includes(value);
}

export const ACCENT_COLORS: { value: AccentColor; label: string; color: string }[] = [
  { value: "coral", label: "Коралл", color: "hsl(16, 90%, 55%)" },
  { value: "blue", label: "Синий", color: "hsl(217, 91%, 60%)" },
  { value: "green", label: "Зелёный", color: "hsl(142, 70%, 45%)" },
  { value: "purple", label: "Фиолетовый", color: "hsl(270, 70%, 60%)" },
  { value: "pink", label: "Розовый", color: "hsl(330, 80%, 60%)" },
  { value: "teal", label: "Бирюзовый", color: "hsl(175, 70%, 45%)" },
];
