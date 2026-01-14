import { useState, useMemo } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { format, isToday, parseISO, differenceInYears } from "date-fns";
import { ru, enUS, es, ptBR, de, fr, Locale } from "date-fns/locale";
import { Loader2, Dumbbell, User, Activity, Timer, MessageSquare, ImageIcon, Trophy, UserPlus, Calendar, Weight } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useSharedWorkout } from "@/hooks/useWorkoutShare";
import { useUserProfile } from "@/hooks/useProfile";
import { useAuth } from "@/contexts/AuthContext";
import { AuthModal } from "@/components/AuthModal";
import { cn } from "@/lib/utils";
import { useTheme } from "next-themes";
import { useTranslation } from "react-i18next";
import { getExerciseName } from "@/lib/i18n";

const DATE_LOCALES: Record<string, Locale> = {
  en: enUS,
  es: es,
  "pt-BR": ptBR,
  de: de,
  fr: fr,
  ru: ru,
};

export default function SharedWorkout() {
  const { t, i18n } = useTranslation();
  const dateLocale = DATE_LOCALES[i18n.language] || enUS;
  const { token } = useParams<{ token: string }>();
  const navigate = useNavigate();
  const { data: workout, isLoading } = useSharedWorkout(token);
  const { data: ownerProfile } = useUserProfile(workout?.user_id);
  const { signInWithGoogle } = useAuth();
  const { resolvedTheme } = useTheme();
  const logoSrc = resolvedTheme === "dark" ? "/logo-white.png" : "/logo-black.png";

  // Auth modal state
  const [authModalOpen, setAuthModalOpen] = useState(false);
  const [authModalTab, setAuthModalTab] = useState<"login" | "signup">("signup");

  const openAuthModal = (tab: "login" | "signup") => {
    setAuthModalTab(tab);
    setAuthModalOpen(true);
  };

  const handleGoogleSignIn = async () => {
    try {
      await signInWithGoogle();
    } catch (error) {
      console.error("Google sign-in error:", error);
    }
  };

  // Check if avatar is an emoji (not a URL)
  const isAvatarEmoji = useMemo(() => {
    if (!ownerProfile?.avatar) return false;
    // Check if it's a URL (starts with http/https) or emoji
    return !ownerProfile.avatar.startsWith('http');
  }, [ownerProfile?.avatar]);

  // Calculate age from date of birth
  const ownerAge = useMemo(() => {
    if (!ownerProfile?.date_of_birth) return null;
    return differenceInYears(new Date(), new Date(ownerProfile.date_of_birth));
  }, [ownerProfile?.date_of_birth]);

  // Group sets by exercise
  const setsByExercise = useMemo(() => {
    if (!workout?.workout_sets) return {};
    return workout.workout_sets.reduce((acc, set) => {
      const exerciseId = set.exercise_id;
      if (!acc[exerciseId]) {
        acc[exerciseId] = {
          exercise: set.exercise,
          sets: [],
        };
      }
      acc[exerciseId].sets.push(set);
      return acc;
    }, {} as Record<string, { exercise: typeof workout.workout_sets[0]["exercise"]; sets: typeof workout.workout_sets }>);
  }, [workout?.workout_sets]);

  // Calculate max values per exercise for trophy icons
  const recordSetIds = useMemo(() => {
    const result: Set<string> = new Set();

    Object.entries(setsByExercise).forEach(([, { exercise, sets }]) => {
      if (!sets || sets.length === 0) return;

      const sortedSets = [...sets].sort((a, b) => a.set_number - b.set_number);

      switch (exercise?.type) {
        case "weighted": {
          const maxWeight = Math.max(...sortedSets.map(s => s.weight || 0));
          if (maxWeight > 0) {
            const firstMaxSet = sortedSets.find(s => s.weight === maxWeight);
            if (firstMaxSet) result.add(firstMaxSet.id);
          }
          break;
        }
        case "bodyweight": {
          const maxReps = Math.max(...sortedSets.map(s => s.reps || 0));
          if (maxReps > 0) {
            const firstMaxSet = sortedSets.find(s => s.reps === maxReps);
            if (firstMaxSet) result.add(firstMaxSet.id);
          }
          break;
        }
        case "cardio": {
          const maxDistance = Math.max(...sortedSets.map(s => s.distance_km || 0));
          if (maxDistance > 0) {
            const firstMaxSet = sortedSets.find(s => s.distance_km === maxDistance);
            if (firstMaxSet) result.add(firstMaxSet.id);
          }
          break;
        }
        case "timed": {
          const maxSeconds = Math.max(...sortedSets.map(s => s.plank_seconds || 0));
          if (maxSeconds > 0) {
            const firstMaxSet = sortedSets.find(s => s.plank_seconds === maxSeconds);
            if (firstMaxSet) result.add(firstMaxSet.id);
          }
          break;
        }
      }
    });

    return result;
  }, [setsByExercise]);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-background">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    );
  }

  if (!workout) {
    return (
      <div className="flex flex-col items-center justify-center min-h-screen bg-background px-4">
        <div className="text-center space-y-4">
          <h1 className="text-2xl font-bold text-foreground">{t("workout.notFound")}</h1>
          <p className="text-muted-foreground">{t("workout.linkDeactivated")}</p>
          <Button onClick={() => openAuthModal("signup")}>
            {t("auth.createAccount")}
          </Button>
        </div>
        <AuthModal
          open={authModalOpen}
          onOpenChange={setAuthModalOpen}
          defaultTab={authModalTab}
        />
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background">
      {/* Header Banner */}
      <div className="bg-primary/10 border-b border-primary/20 p-4">
        <div className="max-w-4xl mx-auto">
          <div className="flex items-center justify-between gap-4">
            <div className="flex items-center gap-4 flex-1">
            {ownerProfile?.avatar ? (
              isAvatarEmoji ? (
                // Display emoji avatar
                <div className="w-16 h-16 rounded-full bg-primary/20 flex items-center justify-center border-2 border-primary/30">
                  <span className="text-3xl">{ownerProfile.avatar}</span>
                </div>
              ) : (
                // Display image avatar
                <div className="relative w-16 h-16">
                  <img
                    src={ownerProfile.avatar}
                    alt={ownerProfile.display_name || t("common.anonymous")}
                    className="w-16 h-16 rounded-full object-cover border-2 border-primary/30"
                    onError={(e) => {
                      // Fallback to default icon if image fails to load
                      const target = e.target as HTMLImageElement;
                      target.style.display = 'none';
                      const fallback = target.nextElementSibling as HTMLElement;
                      if (fallback) {
                        fallback.style.display = 'flex';
                      }
                    }}
                  />
                  <div
                    className="hidden absolute inset-0 w-16 h-16 rounded-full bg-primary/20 items-center justify-center border-2 border-primary/30"
                  >
                    <User className="h-8 w-8 text-primary" />
                  </div>
                </div>
              )
            ) : (
              <div className="w-16 h-16 rounded-full bg-primary/20 flex items-center justify-center border-2 border-primary/30">
                <User className="h-8 w-8 text-primary" />
              </div>
            )}
            <div className="flex-1">
              <p className="text-sm text-muted-foreground">{t("workout.viewingWorkouts")}</p>
              <p className="font-bold text-base text-foreground">{ownerProfile?.display_name || t("common.anonymous")}</p>
              <div className="flex items-center gap-3 mt-1 flex-wrap">
                {ownerAge && (
                  <div className="flex items-center gap-1 text-sm text-muted-foreground">
                    <Calendar className="h-3.5 w-3.5" />
                    <span>{ownerAge} {t("plurals.year", { count: ownerAge })}</span>
                  </div>
                )}
                {ownerProfile?.current_weight && (
                  <div className="flex items-center gap-1 text-sm text-muted-foreground">
                    <Weight className="h-3.5 w-3.5" />
                    <span>{ownerProfile.current_weight} {t("units.kg")}</span>
                  </div>
                )}
              </div>
            </div>
            </div>

            {/* Logo */}
            <img
              src={logoSrc}
              alt="Reppy"
              className="h-8 sm:h-10 w-auto cursor-pointer flex-shrink-0"
              onClick={() => openAuthModal("signup")}
            />
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-4xl mx-auto p-4 space-y-6 pb-32">
        {/* Date Header */}
        <div className="space-y-1">
          <h1 className="text-2xl font-bold bg-gradient-to-r from-foreground to-primary bg-clip-text text-transparent">
            {format(new Date(workout.date), "d MMMM yyyy", { locale: dateLocale })}
          </h1>
          <div className="flex items-center gap-2">
            {isToday(parseISO(workout.date)) && (
              <span className="text-xs px-1.5 py-0.5 rounded font-medium bg-green-500/15 text-green-600 dark:text-green-400">
                {t("workouts.today")}
              </span>
            )}
            <span className={cn(
              "text-xs px-1.5 py-0.5 rounded font-medium",
              [0, 6].includes(new Date(workout.date).getDay())
                ? "bg-primary/10 text-primary"
                : "bg-sky-500/10 text-sky-600 dark:text-sky-400"
            )}>
              {format(new Date(workout.date), "EEEE", { locale: dateLocale })}
            </span>
          </div>
        </div>

        {/* Exercises */}
        {Object.keys(setsByExercise).length === 0 ? (
          <Card className="border-dashed">
            <CardContent className="flex flex-col items-center justify-center py-12 text-center">
              <div className="p-4 bg-muted rounded-full mb-4">
                <Dumbbell className="h-8 w-8 text-muted-foreground" />
              </div>
              <h3 className="font-semibold text-foreground mb-1">{t("workout.noExercises")}</h3>
              <p className="text-muted-foreground text-sm">
                {t("workout.addFirstSet")}
              </p>
            </CardContent>
          </Card>
        ) : (
          <div className="space-y-4">
            {Object.entries(setsByExercise).map(([exerciseId, { exercise, sets }]) => (
              <Card key={exerciseId}>
                <CardHeader className="pb-2 pt-4 px-4">
                  <div className="flex items-center justify-between gap-2">
                    <CardTitle className="flex items-center gap-2 text-base">
                      {exercise?.type === "weighted" ? (
                        <Dumbbell className="h-4 w-4 text-primary" />
                      ) : exercise?.type === "cardio" ? (
                        <Activity className="h-4 w-4 text-primary" />
                      ) : exercise?.type === "timed" ? (
                        <Timer className="h-4 w-4 text-primary" />
                      ) : (
                        <User className="h-4 w-4 text-primary" />
                      )}
                      {exercise?.name ? getExerciseName(exercise.name, (exercise as any).name_translations) : ""}
                    </CardTitle>
                    {exercise?.image_url && (
                      <div className="w-16 h-16 rounded-lg overflow-hidden bg-muted flex-shrink-0">
                        <img
                          src={exercise.image_url}
                          alt={exercise?.name ? getExerciseName(exercise.name, (exercise as any).name_translations) : ""}
                          className="w-full h-full object-cover"
                        />
                      </div>
                    )}
                  </div>
                </CardHeader>
                <CardContent className="space-y-1 px-4 pb-4">
                  {/* Table Header */}
                  <div className={cn(
                    "grid gap-1 px-2 py-1.5 text-[10px] font-semibold text-muted-foreground uppercase tracking-wide",
                    exercise?.type === "bodyweight" || exercise?.type === "timed"
                      ? "grid-cols-[44px_1fr]"
                      : "grid-cols-[44px_1fr_1fr]"
                  )}>
                    <div className="text-center">#</div>
                    <div className="text-center">
                      {exercise?.type === "cardio" ? t("progress.distance") :
                       exercise?.type === "timed" ? t("progress.time") :
                       t("workout.reps")}
                    </div>
                    {exercise?.type !== "bodyweight" && exercise?.type !== "timed" && (
                      <div className="text-center">
                        {exercise?.type === "cardio" ? t("progress.time") : t("workout.weightKg")}
                      </div>
                    )}
                  </div>

                  {/* Table Rows */}
                  {sets.sort((a, b) => a.set_number - b.set_number).map((set) => (
                    <div
                      key={set.id}
                      className={cn(
                        "relative grid gap-1 items-center py-2 px-2 rounded-md",
                        exercise?.type === "bodyweight" || exercise?.type === "timed"
                          ? "grid-cols-[44px_1fr]"
                          : "grid-cols-[44px_1fr_1fr]",
                        recordSetIds.has(set.id)
                          ? "bg-yellow-100 dark:bg-yellow-900/30"
                          : "bg-muted/30"
                      )}
                    >
                      {recordSetIds.has(set.id) && (
                        <Trophy className="absolute left-1.5 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-yellow-500" />
                      )}
                      <div className="text-center text-sm font-medium text-muted-foreground">
                        {set.set_number}
                      </div>
                      {exercise?.type === "cardio" ? (
                        <>
                          <div className="text-center text-sm font-semibold text-foreground">
                            {set.distance_km ? `${set.distance_km} ${t("units.km")}` : '—'}
                          </div>
                          <div className="text-center text-sm font-medium text-primary">
                            {set.duration_minutes ? `${set.duration_minutes} ${t("units.min")}` : '—'}
                          </div>
                        </>
                      ) : exercise?.type === "timed" ? (
                        <div className="text-center text-sm font-semibold text-primary">
                          {set.plank_seconds ? `${set.plank_seconds} ${t("units.sec")}` : '—'}
                        </div>
                      ) : exercise?.type === "bodyweight" ? (
                        <div className="text-center text-sm font-semibold text-foreground">
                          {set.reps || '—'}
                        </div>
                      ) : (
                        <>
                          <div className="text-center text-sm font-semibold text-foreground">
                            {set.reps || '—'}
                          </div>
                          <div className="text-center text-sm font-medium text-primary">
                            {set.weight ? `${set.weight} ${t("units.kg")}` : '—'}
                          </div>
                        </>
                      )}
                    </div>
                  ))}
                </CardContent>
              </Card>
            ))}
          </div>
        )}

        {/* Notes Card */}
        {workout.notes && (
          <Card>
            <CardHeader className="pb-2 pt-4 px-4">
              <CardTitle className="text-base flex items-center gap-2">
                <MessageSquare className="h-4 w-4 text-primary" />
                {t("workout.comment")}
              </CardTitle>
            </CardHeader>
            <CardContent className="px-4 pb-4">
              <div className="text-sm text-foreground whitespace-pre-wrap">
                {workout.notes}
              </div>
            </CardContent>
          </Card>
        )}

        {/* Photo Card */}
        {workout.photo_url && (
          <Card>
            <CardHeader className="pb-2 pt-4 px-4">
              <CardTitle className="text-base flex items-center gap-2">
                <ImageIcon className="h-4 w-4 text-primary" />
                {t("workout.photos")}
              </CardTitle>
            </CardHeader>
            <CardContent className="px-4 pb-4">
              <img
                src={workout.photo_url}
                alt={t("workout.workoutPhoto")}
                className="w-full rounded-lg object-cover max-h-80"
              />
            </CardContent>
          </Card>
        )}
      </div>

      {/* Fixed Bottom CTA */}
      <div className="fixed bottom-0 left-0 right-0 bg-background/95 backdrop-blur-sm border-t border-border p-4">
        <div className="max-w-4xl mx-auto flex flex-col gap-3">
          <p className="text-center text-sm text-muted-foreground">
            {t("auth.subtitle")}
          </p>
          <div className="flex gap-3">
            <Button
              className="flex-1 gap-2"
              onClick={() => openAuthModal("signup")}
            >
              <UserPlus className="h-4 w-4" />
              {t("auth.createAccount")}
            </Button>
            <Button
              variant="outline"
              className="flex-1 gap-2"
              onClick={handleGoogleSignIn}
            >
              <svg className="h-4 w-4" viewBox="0 0 24 24">
                <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
                <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
              </svg>
              {t("auth.continueWithGoogle")}
            </Button>
          </div>
        </div>
      </div>

      {/* Auth Modal */}
      <AuthModal
        open={authModalOpen}
        onOpenChange={setAuthModalOpen}
        defaultTab={authModalTab}
      />
    </div>
  );
}
