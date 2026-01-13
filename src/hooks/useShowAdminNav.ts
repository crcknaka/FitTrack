import { useSyncExternalStore, useCallback } from "react";

const STORAGE_KEY = "fittrack-show-admin-nav";

// Get current value from localStorage
function getSnapshot(): boolean {
  const stored = localStorage.getItem(STORAGE_KEY);
  return stored === null ? true : stored === "true";
}

// Server snapshot (for SSR, though not used here)
function getServerSnapshot(): boolean {
  return true;
}

// Subscribe to storage changes
function subscribe(callback: () => void): () => void {
  // Listen to custom event for same-tab updates
  const handleStorageChange = () => callback();
  window.addEventListener("showAdminNavChange", handleStorageChange);
  // Also listen to storage event for cross-tab sync
  window.addEventListener("storage", (e) => {
    if (e.key === STORAGE_KEY) callback();
  });

  return () => {
    window.removeEventListener("showAdminNavChange", handleStorageChange);
    window.removeEventListener("storage", handleStorageChange);
  };
}

export function useShowAdminNav() {
  const showAdminNav = useSyncExternalStore(subscribe, getSnapshot, getServerSnapshot);

  const setShowAdminNav = useCallback((show: boolean) => {
    localStorage.setItem(STORAGE_KEY, show.toString());
    // Dispatch custom event for same-tab updates
    window.dispatchEvent(new Event("showAdminNavChange"));
  }, []);

  return {
    showAdminNav,
    setShowAdminNav,
  };
}
