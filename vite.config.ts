import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";
import { VitePWA } from "vite-plugin-pwa";
import path from "path";

// https://vitejs.dev/config/
export default defineConfig(() => ({
  server: {
    host: "::",
    port: 8080,
    hmr: {
      overlay: false,
    },
  },
  plugins: [
    react(),
    VitePWA({
      registerType: "autoUpdate",
      includeAssets: ["favicon.ico", "icon-192.png", "icon-512.png", "logo-white.png", "logo-black.png"],
      manifest: false, // Use existing manifest.json
      devOptions: {
        enabled: false, // PWA disabled in dev mode - use npm run build && npm run preview to test
      },
      workbox: {
        globPatterns: ["**/*.{js,css,html,ico,png,svg,woff2,json,jpg,jpeg,webp}"],
        // Ensure all lazy-loaded chunks are precached
        navigateFallback: "index.html",
        navigateFallbackDenylist: [/^\/api/, /^\/auth/],
        runtimeCaching: [
          {
            // Cache app JS/CSS chunks (for lazy loading)
            urlPattern: /\/assets\/.*\.(js|css)$/i,
            handler: "CacheFirst",
            options: {
              cacheName: "app-assets",
              expiration: {
                maxEntries: 100,
                maxAgeSeconds: 60 * 60 * 24 * 30, // 30 days
              },
            },
          },
          {
            // Cache local exercise images
            urlPattern: /\/exercises\/.*\.(jpg|jpeg|png|webp)$/i,
            handler: "CacheFirst",
            options: {
              cacheName: "exercise-images",
              expiration: {
                maxEntries: 50,
                maxAgeSeconds: 60 * 60 * 24 * 365, // 1 year
              },
            },
          },
          {
            // Cache Supabase storage (exercise images, avatars)
            urlPattern: /^https:\/\/.*\.supabase\.co\/storage\/.*/i,
            handler: "CacheFirst",
            options: {
              cacheName: "supabase-storage",
              expiration: {
                maxEntries: 200,
                maxAgeSeconds: 60 * 60 * 24 * 30, // 30 days
              },
              cacheableResponse: {
                statuses: [0, 200],
              },
            },
          },
        ],
        // Skip Supabase API/auth requests - app handles offline with IndexedDB
        skipWaiting: true,
        clientsClaim: true,
      },
    }),
  ],
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
