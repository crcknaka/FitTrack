import { ThemeProvider as NextThemesProvider, useTheme } from "next-themes";
import { useEffect, type ComponentProps } from "react";

type ThemeProviderProps = ComponentProps<typeof NextThemesProvider>;

const THEME_COLORS = {
  light: "#f5f6f8", // HSL(220, 20%, 97%)
  dark: "#0f1419", // HSL(220, 25%, 8%)
};

function ThemeColorSync() {
  const { resolvedTheme } = useTheme();

  useEffect(() => {
    const themeColorMeta = document.querySelector('meta[name="theme-color"]');
    if (themeColorMeta && resolvedTheme) {
      const color = resolvedTheme === "dark" ? THEME_COLORS.dark : THEME_COLORS.light;
      themeColorMeta.setAttribute("content", color);
    }
  }, [resolvedTheme]);

  return null;
}

export function ThemeProvider({ children, ...props }: ThemeProviderProps) {
  return (
    <NextThemesProvider {...props}>
      <ThemeColorSync />
      {children}
    </NextThemesProvider>
  );
}
