import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";
import path from "path";

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => ({
  server: {
    host: "::",
    port: 8080,
    hmr: {
      overlay: false,
    },
  },
  plugins: [react()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
  build: {
    chunkSizeWarningLimit: 1000,
    rollupOptions: {
      output: {
        manualChunks: {
          // Разделяем React и связанные библиотеки
          'react-vendor': ['react', 'react-dom', 'react-router-dom'],

          // UI библиотека и иконки в отдельный чанк
          'ui-vendor': [
            'lucide-react',
            '@radix-ui/react-dialog',
            '@radix-ui/react-select',
            '@radix-ui/react-tooltip',
            '@radix-ui/react-alert-dialog',
            '@radix-ui/react-label',
            '@radix-ui/react-slot',
          ],

          // Библиотеки для работы с датами
          'date-vendor': ['date-fns'],

          // Supabase и React Query
          'data-vendor': ['@supabase/supabase-js', '@tanstack/react-query'],

          // Остальные утилиты
          'utils-vendor': ['sonner', 'class-variance-authority', 'clsx', 'tailwind-merge'],
        },
      },
    },
  },
}));
