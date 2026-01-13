import { View, Text, StyleSheet } from "@react-pdf/renderer";
import { colors } from "../colors";
import type { DailyWorkoutData } from "../hooks/useMonthlyReportData";

interface PdfDailyBreakdownProps {
  dailyData: DailyWorkoutData[];
  labels: {
    title: string;
    sets: string;
    reps: string;
    weight: string;
    volume: string;
    distance: string;
    time: string;
    plank: string;
  };
  units: {
    kg: string;
    km: string;
    min: string;
    sec: string;
  };
  formatDate: (date: string) => string;
  primaryColor: string;
}

const localStyles = StyleSheet.create({
  container: {
    marginTop: 16,
  },
  title: {
    fontSize: 14,
    fontWeight: 700,
    color: colors.text,
    marginBottom: 12,
    paddingBottom: 6,
    borderBottomWidth: 2,
  },
  dayCard: {
    marginBottom: 12,
    backgroundColor: colors.surface,
    borderRadius: 8,
    padding: 12,
    borderWidth: 1,
    borderColor: colors.border,
  },
  dayHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: 10,
    paddingBottom: 8,
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
  },
  dayDate: {
    fontSize: 11,
    fontWeight: 700,
  },
  dayStatsRow: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: 8,
  },
  dayStat: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
    backgroundColor: colors.background,
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 4,
  },
  dayStatValue: {
    fontSize: 8,
    fontWeight: 700,
    color: colors.text,
  },
  dayStatLabel: {
    fontSize: 7,
    color: colors.textMuted,
  },
  exerciseRow: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: 5,
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
    borderBottomStyle: "dotted",
  },
  exerciseRowLast: {
    borderBottomWidth: 0,
  },
  exerciseName: {
    flex: 1,
    fontSize: 9,
    color: colors.text,
    fontWeight: 500,
  },
  exerciseDetails: {
    fontSize: 8,
    color: colors.textMuted,
    textAlign: "right",
    width: 140,
  },
});

export function PdfDailyBreakdown({
  dailyData,
  labels,
  units,
  formatDate,
  primaryColor,
}: PdfDailyBreakdownProps) {
  if (dailyData.length === 0) {
    return null;
  }

  const formatExerciseDetails = (
    exercise: DailyWorkoutData["exercises"][0]
  ): string => {
    const parts: string[] = [];

    switch (exercise.type) {
      case "weighted":
        parts.push(`${exercise.sets} ${labels.sets}`);
        if (exercise.reps > 0) {
          parts.push(`${exercise.reps} ${labels.reps}`);
        }
        if (exercise.maxWeight) {
          parts.push(`${exercise.maxWeight} ${units.kg}`);
        }
        break;
      case "bodyweight":
        parts.push(`${exercise.sets} ${labels.sets}`);
        if (exercise.reps > 0) {
          parts.push(`${exercise.reps} ${labels.reps}`);
        }
        break;
      case "cardio":
        if (exercise.distance) {
          parts.push(`${exercise.distance.toFixed(1)} ${units.km}`);
        }
        if (exercise.duration) {
          parts.push(`${Math.round(exercise.duration)} ${units.min}`);
        }
        break;
      case "timed":
        if (exercise.plankSeconds) {
          if (exercise.plankSeconds >= 60) {
            const mins = Math.floor(exercise.plankSeconds / 60);
            const secs = exercise.plankSeconds % 60;
            parts.push(`${mins}${units.min} ${secs}${units.sec}`);
          } else {
            parts.push(`${exercise.plankSeconds} ${units.sec}`);
          }
        }
        break;
    }

    return parts.join(" · ");
  };

  // Format duration from minutes
  const formatDuration = (minutes: number): string => {
    if (minutes < 60) {
      return `${Math.round(minutes)} ${units.min}`;
    }
    const hours = Math.floor(minutes / 60);
    const mins = Math.round(minutes % 60);
    return mins > 0 ? `${hours}h ${mins}${units.min}` : `${hours}h`;
  };

  // Format plank time from seconds
  const formatPlankTime = (seconds: number): string => {
    if (seconds < 60) {
      return `${seconds}${units.sec}`;
    }
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return secs > 0 ? `${mins}${units.min} ${secs}${units.sec}` : `${mins}${units.min}`;
  };

  return (
    <View style={localStyles.container}>
      <Text style={[localStyles.title, { borderBottomColor: primaryColor }]}>{labels.title}</Text>
      {dailyData.map((day, dayIndex) => (
        <View key={dayIndex} style={localStyles.dayCard} wrap={false}>
          {/* Day Header with Date */}
          <View style={localStyles.dayHeader}>
            <Text style={[localStyles.dayDate, { color: primaryColor }]}>{formatDate(day.date)}</Text>
          </View>

          {/* Day Stats Row */}
          <View style={[localStyles.dayStatsRow, { marginBottom: 10 }]}>
            {/* Sets */}
            <View style={localStyles.dayStat}>
              <Text style={localStyles.dayStatValue}>{day.sets}</Text>
              <Text style={localStyles.dayStatLabel}>{labels.sets}</Text>
            </View>

            {/* Reps (if any) */}
            {day.reps > 0 && (
              <View style={localStyles.dayStat}>
                <Text style={localStyles.dayStatValue}>{day.reps.toLocaleString()}</Text>
                <Text style={localStyles.dayStatLabel}>{labels.reps}</Text>
              </View>
            )}

            {/* Volume (if any) */}
            {day.volume > 0 && (
              <View style={localStyles.dayStat}>
                <Text style={localStyles.dayStatValue}>{day.volume.toLocaleString()}</Text>
                <Text style={localStyles.dayStatLabel}>{units.kg}</Text>
              </View>
            )}

            {/* Distance (if any cardio) */}
            {day.distance > 0 && (
              <View style={localStyles.dayStat}>
                <Text style={localStyles.dayStatValue}>{day.distance.toFixed(1)}</Text>
                <Text style={localStyles.dayStatLabel}>{units.km}</Text>
              </View>
            )}

            {/* Duration (if any cardio) */}
            {day.durationMinutes > 0 && (
              <View style={localStyles.dayStat}>
                <Text style={localStyles.dayStatValue}>{formatDuration(day.durationMinutes)}</Text>
                <Text style={localStyles.dayStatLabel}>{labels.time}</Text>
              </View>
            )}

            {/* Plank time (if any timed) */}
            {day.plankSeconds > 0 && (
              <View style={localStyles.dayStat}>
                <Text style={localStyles.dayStatValue}>{formatPlankTime(day.plankSeconds)}</Text>
                <Text style={localStyles.dayStatLabel}>{labels.plank}</Text>
              </View>
            )}
          </View>

          {/* Exercises List */}
          {day.exercises.map((exercise, exIndex) => (
            <View
              key={exIndex}
              style={[
                localStyles.exerciseRow,
                exIndex === day.exercises.length - 1 &&
                  localStyles.exerciseRowLast,
              ]}
            >
              <Text style={localStyles.exerciseName}>{exercise.name}</Text>
              <Text style={localStyles.exerciseDetails}>
                {formatExerciseDetails(exercise)}
              </Text>
            </View>
          ))}
        </View>
      ))}
    </View>
  );
}
