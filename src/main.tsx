import { createRoot } from "react-dom/client";
import { registerSW } from "virtual:pwa-register";
import App from "./App.tsx";
import "./index.css";
import "./lib/i18n";

// Register service worker for PWA
const updateSW = registerSW({
  onNeedRefresh() {
    // Could show a toast here asking user to refresh
    console.log("New content available, please refresh.");
  },
  onOfflineReady() {
    console.log("App ready for offline use.");
  },
  onRegistered(registration) {
    console.log("Service worker registered:", registration);
  },
  onRegisterError(error) {
    console.error("Service worker registration error:", error);
  },
});

// Initialize accent color from localStorage before React renders
const ACCENT_STORAGE_KEY = "fittrack-accent-color";
const VALID_ACCENTS = ["coral", "blue", "green", "purple", "pink", "teal", "amber", "indigo", "cyan", "lime", "orange", "slate"];
const storedAccent = localStorage.getItem(ACCENT_STORAGE_KEY);

if (storedAccent && VALID_ACCENTS.includes(storedAccent)) {
  document.documentElement.setAttribute("data-accent", storedAccent);
} else {
  document.documentElement.setAttribute("data-accent", "coral");
}

createRoot(document.getElementById("root")!).render(<App />);
