import { useState } from "react";
import { useTranslation } from "react-i18next";
import { AdminLayout } from "@/components/admin/AdminLayout";
import {
  useEmptyWorkouts,
  useDeleteEmptyWorkouts,
  useOrphanedExercises,
  useDeleteOrphanedExercises,
  useUnusedExercises,
  useDeleteUnusedExercises,
  type EmptyWorkout,
  type UnusedExercise,
} from "@/hooks/admin/useAdminCleanup";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Checkbox } from "@/components/ui/checkbox";
import { Trash2, FileX, Link2Off, Loader2, User, ChevronRight, Calendar, Dumbbell, Copy } from "lucide-react";
import { toast } from "sonner";
import { format } from "date-fns";
import { cn } from "@/lib/utils";

export default function AdminCleanup() {
  const { t } = useTranslation();
  const [deleteEmptyDialog, setDeleteEmptyDialog] = useState(false);
  const [deleteOrphanedDialog, setDeleteOrphanedDialog] = useState(false);
  const [deleteUnusedDialog, setDeleteUnusedDialog] = useState(false);
  const [showEmptyList, setShowEmptyList] = useState(false);
  const [showUnusedList, setShowUnusedList] = useState(false);
  const [selectedWorkouts, setSelectedWorkouts] = useState<Set<string>>(new Set());
  const [selectedExercises, setSelectedExercises] = useState<Set<string>>(new Set());

  const { data: emptyWorkouts, isLoading: loadingEmpty } = useEmptyWorkouts();
  const { data: orphanedCount, isLoading: loadingOrphaned } = useOrphanedExercises();
  const { data: unusedExercises, isLoading: loadingUnused } = useUnusedExercises(30);

  const deleteEmptyMutation = useDeleteEmptyWorkouts();
  const deleteOrphanedMutation = useDeleteOrphanedExercises();
  const deleteUnusedMutation = useDeleteUnusedExercises();

  const copyToClipboard = async (id: string) => {
    try {
      await navigator.clipboard.writeText(id);
      toast.success(t("admin.cleanup.idCopied"));
    } catch {
      toast.error(t("common.error"));
    }
  };

  const handleDeleteEmpty = async () => {
    if (!emptyWorkouts || emptyWorkouts.length === 0) return;

    try {
      const count = await deleteEmptyMutation.mutateAsync(
        emptyWorkouts.map((w) => w.id)
      );
      toast.success(t("admin.cleanup.deleted", { count }));
    } catch {
      toast.error(t("common.error"));
    }
    setDeleteEmptyDialog(false);
  };

  const handleDeleteSelected = async () => {
    if (selectedWorkouts.size === 0) return;

    try {
      const count = await deleteEmptyMutation.mutateAsync(
        Array.from(selectedWorkouts)
      );
      toast.success(t("admin.cleanup.deleted", { count }));
      setSelectedWorkouts(new Set());
    } catch {
      toast.error(t("common.error"));
    }
  };

  const handleDeleteOrphaned = async () => {
    try {
      const count = await deleteOrphanedMutation.mutateAsync();
      toast.success(t("admin.cleanup.deleted", { count }));
    } catch {
      toast.error(t("common.error"));
    }
    setDeleteOrphanedDialog(false);
  };

  const handleDeleteUnused = async () => {
    if (!unusedExercises || unusedExercises.length === 0) return;

    try {
      const count = await deleteUnusedMutation.mutateAsync(
        unusedExercises.map((e) => e.id)
      );
      toast.success(t("admin.cleanup.deleted", { count }));
    } catch {
      toast.error(t("common.error"));
    }
    setDeleteUnusedDialog(false);
  };

  const handleDeleteSelectedExercises = async () => {
    if (selectedExercises.size === 0) return;

    try {
      const count = await deleteUnusedMutation.mutateAsync(
        Array.from(selectedExercises)
      );
      toast.success(t("admin.cleanup.deleted", { count }));
      setSelectedExercises(new Set());
    } catch {
      toast.error(t("common.error"));
    }
  };

  const toggleWorkout = (id: string) => {
    const newSet = new Set(selectedWorkouts);
    if (newSet.has(id)) {
      newSet.delete(id);
    } else {
      newSet.add(id);
    }
    setSelectedWorkouts(newSet);
  };

  const toggleAll = () => {
    if (!emptyWorkouts) return;
    if (selectedWorkouts.size === emptyWorkouts.length) {
      setSelectedWorkouts(new Set());
    } else {
      setSelectedWorkouts(new Set(emptyWorkouts.map((w) => w.id)));
    }
  };

  const toggleExercise = (id: string) => {
    const newSet = new Set(selectedExercises);
    if (newSet.has(id)) {
      newSet.delete(id);
    } else {
      newSet.add(id);
    }
    setSelectedExercises(newSet);
  };

  const toggleAllExercises = () => {
    if (!unusedExercises) return;
    if (selectedExercises.size === unusedExercises.length) {
      setSelectedExercises(new Set());
    } else {
      setSelectedExercises(new Set(unusedExercises.map((e) => e.id)));
    }
  };

  // Group workouts by user
  const workoutsByUser = emptyWorkouts?.reduce((acc, workout) => {
    const key = workout.user_id;
    if (!acc[key]) {
      acc[key] = {
        user_id: workout.user_id,
        display_name: workout.display_name,
        avatar: workout.avatar,
        workouts: [],
      };
    }
    acc[key].workouts.push(workout);
    return acc;
  }, {} as Record<string, { user_id: string; display_name: string | null; avatar: string | null; workouts: EmptyWorkout[] }>);

  const userGroups = workoutsByUser ? Object.values(workoutsByUser) : [];

  // Group exercises by user
  const exercisesByUser = unusedExercises?.reduce((acc, exercise) => {
    const key = exercise.user_id;
    if (!acc[key]) {
      acc[key] = {
        user_id: exercise.user_id,
        display_name: exercise.display_name,
        avatar: exercise.avatar,
        exercises: [],
      };
    }
    acc[key].exercises.push(exercise);
    return acc;
  }, {} as Record<string, { user_id: string; display_name: string | null; avatar: string | null; exercises: UnusedExercise[] }>);

  const exerciseUserGroups = exercisesByUser ? Object.values(exercisesByUser) : [];

  return (
    <AdminLayout>
      <div className="space-y-6">
        <div>
          <h1 className="text-2xl font-bold">{t("admin.nav.cleanup")}</h1>
          <p className="text-muted-foreground">{t("admin.cleanupDesc")}</p>
        </div>

        <div className="grid gap-4 md:grid-cols-2">
          {/* Empty Workouts */}
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <FileX className="h-5 w-5" />
                {t("admin.cleanup.emptyWorkouts")}
              </CardTitle>
              <CardDescription>
                {t("admin.cleanup.emptyWorkoutsDesc")}
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <button
                onClick={() => emptyWorkouts && emptyWorkouts.length > 0 && setShowEmptyList(true)}
                disabled={loadingEmpty || !emptyWorkouts || emptyWorkouts.length === 0}
                className={cn(
                  "w-full flex items-center justify-between p-4 bg-muted/50 rounded-lg transition-colors",
                  emptyWorkouts && emptyWorkouts.length > 0 && "hover:bg-muted cursor-pointer"
                )}
              >
                <span className="font-medium">{t("admin.cleanup.found")}</span>
                <div className="flex items-center gap-2">
                  <span className="text-2xl font-bold">
                    {loadingEmpty ? (
                      <Loader2 className="h-5 w-5 animate-spin" />
                    ) : (
                      emptyWorkouts?.length || 0
                    )}
                  </span>
                  {emptyWorkouts && emptyWorkouts.length > 0 && (
                    <ChevronRight className="h-4 w-4 text-muted-foreground" />
                  )}
                </div>
              </button>
              <Button
                variant="destructive"
                className="w-full"
                disabled={
                  loadingEmpty ||
                  !emptyWorkouts ||
                  emptyWorkouts.length === 0 ||
                  deleteEmptyMutation.isPending
                }
                onClick={() => setDeleteEmptyDialog(true)}
              >
                {deleteEmptyMutation.isPending ? (
                  <Loader2 className="h-4 w-4 animate-spin mr-2" />
                ) : (
                  <Trash2 className="h-4 w-4 mr-2" />
                )}
                {t("admin.cleanup.deleteAll")}
              </Button>
            </CardContent>
          </Card>

          {/* Orphaned Exercises */}
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Link2Off className="h-5 w-5" />
                {t("admin.cleanup.orphanedExercises")}
              </CardTitle>
              <CardDescription>
                {t("admin.cleanup.orphanedExercisesDesc")}
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex items-center justify-between p-4 bg-muted/50 rounded-lg">
                <span className="font-medium">{t("admin.cleanup.found")}</span>
                <span className="text-2xl font-bold">
                  {loadingOrphaned ? (
                    <Loader2 className="h-5 w-5 animate-spin" />
                  ) : (
                    orphanedCount || 0
                  )}
                </span>
              </div>
              <Button
                variant="destructive"
                className="w-full"
                disabled={
                  loadingOrphaned ||
                  !orphanedCount ||
                  orphanedCount === 0 ||
                  deleteOrphanedMutation.isPending
                }
                onClick={() => setDeleteOrphanedDialog(true)}
              >
                {deleteOrphanedMutation.isPending ? (
                  <Loader2 className="h-4 w-4 animate-spin mr-2" />
                ) : (
                  <Trash2 className="h-4 w-4 mr-2" />
                )}
                {t("admin.cleanup.deleteAll")}
              </Button>
            </CardContent>
          </Card>

          {/* Unused Exercises */}
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Dumbbell className="h-5 w-5" />
                {t("admin.cleanup.unusedExercises")}
              </CardTitle>
              <CardDescription>
                {t("admin.cleanup.unusedExercisesDesc")}
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <button
                onClick={() => unusedExercises && unusedExercises.length > 0 && setShowUnusedList(true)}
                disabled={loadingUnused || !unusedExercises || unusedExercises.length === 0}
                className={cn(
                  "w-full flex items-center justify-between p-4 bg-muted/50 rounded-lg transition-colors",
                  unusedExercises && unusedExercises.length > 0 && "hover:bg-muted cursor-pointer"
                )}
              >
                <span className="font-medium">{t("admin.cleanup.found")}</span>
                <div className="flex items-center gap-2">
                  <span className="text-2xl font-bold">
                    {loadingUnused ? (
                      <Loader2 className="h-5 w-5 animate-spin" />
                    ) : (
                      unusedExercises?.length || 0
                    )}
                  </span>
                  {unusedExercises && unusedExercises.length > 0 && (
                    <ChevronRight className="h-4 w-4 text-muted-foreground" />
                  )}
                </div>
              </button>
              <Button
                variant="destructive"
                className="w-full"
                disabled={
                  loadingUnused ||
                  !unusedExercises ||
                  unusedExercises.length === 0 ||
                  deleteUnusedMutation.isPending
                }
                onClick={() => setDeleteUnusedDialog(true)}
              >
                {deleteUnusedMutation.isPending ? (
                  <Loader2 className="h-4 w-4 animate-spin mr-2" />
                ) : (
                  <Trash2 className="h-4 w-4 mr-2" />
                )}
                {t("admin.cleanup.deleteAll")}
              </Button>
            </CardContent>
          </Card>
        </div>

        {/* Empty Workouts List Dialog */}
        <Dialog open={showEmptyList} onOpenChange={setShowEmptyList}>
          <DialogContent className="max-w-2xl max-h-[80vh] overflow-hidden flex flex-col">
            <DialogHeader>
              <DialogTitle className="flex items-center justify-between">
                <span>{t("admin.cleanup.emptyWorkouts")} ({emptyWorkouts?.length || 0})</span>
              </DialogTitle>
            </DialogHeader>

            {/* Select all / Delete selected */}
            <div className="flex items-center justify-between py-2 border-b">
              <label className="flex items-center gap-2 cursor-pointer">
                <Checkbox
                  checked={emptyWorkouts && selectedWorkouts.size === emptyWorkouts.length && emptyWorkouts.length > 0}
                  onCheckedChange={toggleAll}
                />
                <span className="text-sm">{t("admin.cleanup.selectAll")}</span>
              </label>
              {selectedWorkouts.size > 0 && (
                <Button
                  variant="destructive"
                  size="sm"
                  onClick={handleDeleteSelected}
                  disabled={deleteEmptyMutation.isPending}
                >
                  {deleteEmptyMutation.isPending ? (
                    <Loader2 className="h-4 w-4 animate-spin mr-2" />
                  ) : (
                    <Trash2 className="h-4 w-4 mr-2" />
                  )}
                  {t("admin.cleanup.deleteSelected")} ({selectedWorkouts.size})
                </Button>
              )}
            </div>

            {/* List grouped by user */}
            <div className="flex-1 overflow-y-auto space-y-4 py-2">
              {userGroups.map((group) => (
                <div key={group.user_id} className="space-y-2">
                  {/* User header */}
                  <div className="flex items-center gap-2 sticky top-0 bg-background py-1">
                    <Avatar className="h-8 w-8">
                      <AvatarFallback className="text-lg">
                        {group.avatar || <User className="h-4 w-4" />}
                      </AvatarFallback>
                    </Avatar>
                    <div>
                      <p className="font-medium text-sm">
                        {group.display_name || t("common.anonymous")}
                      </p>
                      <p className="text-xs text-muted-foreground">
                        {group.workouts.length} {t("admin.cleanup.emptyWorkoutsCount")}
                      </p>
                    </div>
                  </div>

                  {/* User's workouts */}
                  <div className="pl-10 space-y-1">
                    {group.workouts.map((workout) => (
                      <div
                        key={workout.id}
                        className={cn(
                          "flex items-center gap-3 p-2 rounded-lg transition-colors",
                          selectedWorkouts.has(workout.id)
                            ? "bg-destructive/10"
                            : "hover:bg-muted/50"
                        )}
                      >
                        <Checkbox
                          checked={selectedWorkouts.has(workout.id)}
                          onCheckedChange={() => toggleWorkout(workout.id)}
                        />
                        <Calendar className="h-4 w-4 text-muted-foreground flex-shrink-0" />
                        <span className="text-sm flex-shrink-0">
                          {format(new Date(workout.date), "dd.MM.yyyy")}
                        </span>
                        <button
                          onClick={() => copyToClipboard(workout.id)}
                          className="flex items-center gap-1 text-xs text-muted-foreground font-mono hover:text-foreground transition-colors truncate min-w-0"
                          title={workout.id}
                        >
                          <Copy className="h-3 w-3 flex-shrink-0" />
                          <span className="truncate">{workout.id}</span>
                        </button>
                      </div>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          </DialogContent>
        </Dialog>

        {/* Delete Empty Workouts Dialog */}
        <AlertDialog open={deleteEmptyDialog} onOpenChange={setDeleteEmptyDialog}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>{t("admin.cleanup.confirmTitle")}</AlertDialogTitle>
              <AlertDialogDescription>
                {t("admin.cleanup.confirmEmptyWorkouts", {
                  count: emptyWorkouts?.length || 0,
                })}
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel>{t("common.cancel")}</AlertDialogCancel>
              <AlertDialogAction
                onClick={handleDeleteEmpty}
                className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
              >
                {t("common.delete")}
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>

        {/* Delete Orphaned Exercises Dialog */}
        <AlertDialog open={deleteOrphanedDialog} onOpenChange={setDeleteOrphanedDialog}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>{t("admin.cleanup.confirmTitle")}</AlertDialogTitle>
              <AlertDialogDescription>
                {t("admin.cleanup.confirmOrphanedExercises", {
                  count: orphanedCount || 0,
                })}
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel>{t("common.cancel")}</AlertDialogCancel>
              <AlertDialogAction
                onClick={handleDeleteOrphaned}
                className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
              >
                {t("common.delete")}
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>

        {/* Unused Exercises List Dialog */}
        <Dialog open={showUnusedList} onOpenChange={setShowUnusedList}>
          <DialogContent className="max-w-2xl max-h-[80vh] overflow-hidden flex flex-col">
            <DialogHeader>
              <DialogTitle className="flex items-center justify-between">
                <span>{t("admin.cleanup.unusedExercises")} ({unusedExercises?.length || 0})</span>
              </DialogTitle>
            </DialogHeader>

            {/* Select all / Delete selected */}
            <div className="flex items-center justify-between py-2 border-b">
              <label className="flex items-center gap-2 cursor-pointer">
                <Checkbox
                  checked={unusedExercises && selectedExercises.size === unusedExercises.length && unusedExercises.length > 0}
                  onCheckedChange={toggleAllExercises}
                />
                <span className="text-sm">{t("admin.cleanup.selectAll")}</span>
              </label>
              {selectedExercises.size > 0 && (
                <Button
                  variant="destructive"
                  size="sm"
                  onClick={handleDeleteSelectedExercises}
                  disabled={deleteUnusedMutation.isPending}
                >
                  {deleteUnusedMutation.isPending ? (
                    <Loader2 className="h-4 w-4 animate-spin mr-2" />
                  ) : (
                    <Trash2 className="h-4 w-4 mr-2" />
                  )}
                  {t("admin.cleanup.deleteSelected")} ({selectedExercises.size})
                </Button>
              )}
            </div>

            {/* List grouped by user */}
            <div className="flex-1 overflow-y-auto space-y-4 py-2">
              {exerciseUserGroups.map((group) => (
                <div key={group.user_id} className="space-y-2">
                  {/* User header */}
                  <div className="flex items-center gap-2 sticky top-0 bg-background py-1">
                    <Avatar className="h-8 w-8">
                      <AvatarFallback className="text-lg">
                        {group.avatar || <User className="h-4 w-4" />}
                      </AvatarFallback>
                    </Avatar>
                    <div>
                      <p className="font-medium text-sm">
                        {group.display_name || t("common.anonymous")}
                      </p>
                      <p className="text-xs text-muted-foreground">
                        {group.exercises.length} {t("admin.cleanup.unusedExercisesCount")}
                      </p>
                    </div>
                  </div>

                  {/* User's exercises */}
                  <div className="pl-10 space-y-1">
                    {group.exercises.map((exercise) => (
                      <div
                        key={exercise.id}
                        className={cn(
                          "flex items-center gap-3 p-2 rounded-lg transition-colors",
                          selectedExercises.has(exercise.id)
                            ? "bg-destructive/10"
                            : "hover:bg-muted/50"
                        )}
                      >
                        <Checkbox
                          checked={selectedExercises.has(exercise.id)}
                          onCheckedChange={() => toggleExercise(exercise.id)}
                        />
                        <Dumbbell className="h-4 w-4 text-muted-foreground flex-shrink-0" />
                        <div className="flex-1 min-w-0">
                          <p className="text-sm font-medium truncate">{exercise.name}</p>
                          <p className="text-xs text-muted-foreground">
                            {exercise.type} · {exercise.last_used_date
                              ? t("admin.cleanup.lastUsed", { date: format(new Date(exercise.last_used_date), "dd.MM.yyyy") })
                              : t("admin.cleanup.neverUsed")}
                          </p>
                        </div>
                        <button
                          onClick={() => copyToClipboard(exercise.id)}
                          className="flex items-center gap-1 text-xs text-muted-foreground font-mono hover:text-foreground transition-colors"
                          title={exercise.id}
                        >
                          <Copy className="h-3 w-3" />
                        </button>
                      </div>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          </DialogContent>
        </Dialog>

        {/* Delete Unused Exercises Dialog */}
        <AlertDialog open={deleteUnusedDialog} onOpenChange={setDeleteUnusedDialog}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>{t("admin.cleanup.confirmTitle")}</AlertDialogTitle>
              <AlertDialogDescription>
                {t("admin.cleanup.confirmUnusedExercises", {
                  count: unusedExercises?.length || 0,
                })}
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel>{t("common.cancel")}</AlertDialogCancel>
              <AlertDialogAction
                onClick={handleDeleteUnused}
                className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
              >
                {t("common.delete")}
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </AdminLayout>
  );
}
