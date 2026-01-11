import { useEffect, useState } from "react";

export type UnitSystem = "metric" | "imperial";

const UNITS_STORAGE_KEY = "fittrack-unit-system";

// Conversion constants
const KG_TO_LB = 2.20462;
const KM_TO_MI = 0.621371;
const CM_TO_FT = 0.0328084;
const CM_TO_IN = 0.393701;

export function useUnits() {
  const [unitSystem, setUnitSystemState] = useState<UnitSystem>(() => {
    if (typeof window !== "undefined") {
      const stored = localStorage.getItem(UNITS_STORAGE_KEY);
      if (stored === "metric" || stored === "imperial") {
        return stored;
      }
    }
    return "metric";
  });

  useEffect(() => {
    localStorage.setItem(UNITS_STORAGE_KEY, unitSystem);
  }, [unitSystem]);

  const setUnitSystem = (system: UnitSystem) => {
    setUnitSystemState(system);
  };

  // Unit labels based on system
  const units = {
    weight: unitSystem === "metric" ? "kg" : "lb",
    distance: unitSystem === "metric" ? "km" : "mi",
    height: unitSystem === "metric" ? "cm" : "ft",
    heightSmall: unitSystem === "metric" ? "cm" : "in",
  };

  // Conversion functions (from metric to display unit)
  const convertWeight = (kg: number): number => {
    if (unitSystem === "imperial") {
      return Math.round(kg * KG_TO_LB * 10) / 10;
    }
    return kg;
  };

  const convertDistance = (km: number): number => {
    if (unitSystem === "imperial") {
      return Math.round(km * KM_TO_MI * 100) / 100;
    }
    return km;
  };

  const convertHeight = (cm: number): { feet: number; inches: number } | number => {
    if (unitSystem === "imperial") {
      const totalInches = cm * CM_TO_IN;
      const feet = Math.floor(totalInches / 12);
      const inches = Math.round(totalInches % 12);
      return { feet, inches };
    }
    return cm;
  };

  // Conversion functions (from display unit to metric for storage)
  const toMetricWeight = (value: number): number => {
    if (unitSystem === "imperial") {
      return Math.round(value / KG_TO_LB * 10) / 10;
    }
    return value;
  };

  const toMetricDistance = (value: number): number => {
    if (unitSystem === "imperial") {
      return Math.round(value / KM_TO_MI * 100) / 100;
    }
    return value;
  };

  const toMetricHeight = (feet: number, inches: number = 0): number => {
    if (unitSystem === "imperial") {
      const totalInches = feet * 12 + inches;
      return Math.round(totalInches / CM_TO_IN);
    }
    return feet; // In metric mode, feet param is actually cm
  };

  // Format weight with unit
  const formatWeight = (kg: number): string => {
    const converted = convertWeight(kg);
    return `${converted} ${units.weight}`;
  };

  // Format distance with unit
  const formatDistance = (km: number): string => {
    const converted = convertDistance(km);
    return `${converted} ${units.distance}`;
  };

  return {
    unitSystem,
    setUnitSystem,
    units,
    convertWeight,
    convertDistance,
    convertHeight,
    toMetricWeight,
    toMetricDistance,
    toMetricHeight,
    formatWeight,
    formatDistance,
  };
}

export const UNIT_SYSTEMS: { value: UnitSystem; labelKey: string }[] = [
  { value: "metric", labelKey: "settings.units.metric" },
  { value: "imperial", labelKey: "settings.units.imperial" },
];
