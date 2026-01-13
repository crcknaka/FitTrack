import { useEffect, useState } from "react";

const STORAGE_KEY = "reppy-autofill-last-set";

export function useAutoFillLastSet() {
  const [autoFillEnabled, setAutoFillEnabledState] = useState<boolean>(() => {
    if (typeof window !== "undefined") {
      const stored = localStorage.getItem(STORAGE_KEY);
      // Default to true (enabled)
      return stored === null ? true : stored === "true";
    }
    return true;
  });

  useEffect(() => {
    localStorage.setItem(STORAGE_KEY, autoFillEnabled.toString());
  }, [autoFillEnabled]);

  const setAutoFillEnabled = (enabled: boolean) => {
    setAutoFillEnabledState(enabled);
  };

  return {
    autoFillEnabled,
    setAutoFillEnabled,
  };
}
