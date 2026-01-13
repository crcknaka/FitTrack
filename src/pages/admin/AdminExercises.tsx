import { useState } from "react";
import { useTranslation } from "react-i18next";
import { AdminLayout } from "@/components/admin/AdminLayout";
import {
  useUserCreatedExercises,
  useDeleteUserExercise,
} from "@/hooks/admin/useAdminStats";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
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
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Skeleton } from "@/components/ui/skeleton";
import {
  Dumbbell,
  Trash2,
  Loader2,
  Search,
  Calendar,
  User,
  Hash,
} from "lucide-react";
import { toast } from "sonner";
import { format } from "date-fns";
import { cn } from "@/lib/utils";

const typeIcons: Record<string, string> = {
  weighted: "weighted",
  bodyweight: "bodyweight",
  cardio: "cardio",
  timed: "timed",
};

export default function AdminExercises() {
  const { t } = useTranslation();
  const [searchQuery, setSearchQuery] = useState("");
  const [deleteExerciseId, setDeleteExerciseId] = useState<string | null>(null);
  const [deleteExerciseName, setDeleteExerciseName] = useState<string>("");

  const { data: exercises, isLoading } = useUserCreatedExercises();
  const deleteMutation = useDeleteUserExercise();

  const filteredExercises = exercises?.filter((exercise) => {
    const query = searchQuery.toLowerCase();
    return (
      exercise.name.toLowerCase().includes(query) ||
      exercise.creator.displayName?.toLowerCase().includes(query) ||
      exercise.creator.username?.toLowerCase().includes(query)
    );
  });

  const handleDelete = async () => {
    if (!deleteExerciseId) return;

    try {
      await deleteMutation.mutateAsync(deleteExerciseId);
      toast.success(t("admin.exercises.deleted"));
    } catch {
      toast.error(t("common.error"));
    }
    setDeleteExerciseId(null);
    setDeleteExerciseName("");
  };

  const copyToClipboard = async (text: string) => {
    try {
      await navigator.clipboard.writeText(text);
      toast.success(t("common.copied"));
    } catch {
      toast.error(t("common.error"));
    }
  };

  return (
    <AdminLayout>
      <div className="space-y-6">
        <div>
          <h1 className="text-2xl font-bold">{t("admin.nav.exercises")}</h1>
          <p className="text-muted-foreground">{t("admin.exercisesDesc")}</p>
        </div>

        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Dumbbell className="h-5 w-5" />
              {t("admin.exercises.userCreated")}
            </CardTitle>
            <CardDescription>
              {t("admin.exercises.userCreatedDesc")}
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            {/* Search */}
            <div className="relative">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input
                placeholder={t("admin.exercises.search")}
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="pl-9"
              />
            </div>

            {/* Count */}
            <div className="flex items-center justify-between p-3 bg-muted/50 rounded-lg">
              <span className="text-sm font-medium">{t("admin.exercises.total")}</span>
              <span className="text-lg font-bold">
                {isLoading ? (
                  <Loader2 className="h-4 w-4 animate-spin" />
                ) : (
                  filteredExercises?.length || 0
                )}
              </span>
            </div>

            {/* List */}
            <div className="space-y-2">
              {isLoading ? (
                [...Array(5)].map((_, i) => (
                  <div key={i} className="flex items-center gap-3 p-3 rounded-lg border">
                    <Skeleton className="h-10 w-10 rounded-full" />
                    <div className="flex-1 space-y-2">
                      <Skeleton className="h-4 w-32" />
                      <Skeleton className="h-3 w-48" />
                    </div>
                    <Skeleton className="h-8 w-8" />
                  </div>
                ))
              ) : filteredExercises && filteredExercises.length > 0 ? (
                filteredExercises.map((exercise) => (
                  <div
                    key={exercise.id}
                    className="flex items-center gap-3 p-3 rounded-lg border hover:bg-muted/30 transition-colors"
                  >
                    {/* Exercise Icon */}
                    <div className="h-10 w-10 rounded-full bg-primary/10 flex items-center justify-center flex-shrink-0">
                      <Dumbbell className="h-5 w-5 text-primary" />
                    </div>

                    {/* Exercise Info */}
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2">
                        <span className="font-medium truncate">{exercise.name}</span>
                        <span className="text-xs px-2 py-0.5 rounded-full bg-muted text-muted-foreground">
                          {t(`progress.${exercise.type}`)}
                        </span>
                      </div>
                      <div className="flex items-center gap-4 text-xs text-muted-foreground mt-1">
                        {/* Creator */}
                        <div className="flex items-center gap-1">
                          <Avatar className="h-4 w-4">
                            <AvatarImage src={exercise.creator.avatar || undefined} />
                            <AvatarFallback className="text-[8px]">
                              {exercise.creator.displayName?.charAt(0)?.toUpperCase() || "?"}
                            </AvatarFallback>
                          </Avatar>
                          <span className="truncate max-w-[100px]">
                            {exercise.creator.displayName || t("common.anonymous")}
                          </span>
                          {exercise.creator.username && (
                            <span
                              className="text-muted-foreground hover:text-primary cursor-pointer"
                              onClick={() => copyToClipboard(`@${exercise.creator.username}`)}
                            >
                              @{exercise.creator.username}
                            </span>
                          )}
                        </div>

                        {/* Last Used */}
                        <div className="flex items-center gap-1">
                          <Calendar className="h-3 w-3" />
                          <span>
                            {exercise.lastUsedDate
                              ? format(new Date(exercise.lastUsedDate), "dd.MM.yyyy")
                              : t("admin.exercises.neverUsed")}
                          </span>
                        </div>

                        {/* Usage Count */}
                        <div className="flex items-center gap-1">
                          <Hash className="h-3 w-3" />
                          <span>{exercise.usageCount}</span>
                        </div>
                      </div>
                    </div>

                    {/* Delete Button */}
                    <Button
                      variant="ghost"
                      size="icon"
                      className="text-destructive hover:text-destructive hover:bg-destructive/10 flex-shrink-0"
                      onClick={() => {
                        setDeleteExerciseId(exercise.id);
                        setDeleteExerciseName(exercise.name);
                      }}
                    >
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </div>
                ))
              ) : (
                <p className="text-center text-muted-foreground py-8">
                  {searchQuery ? t("admin.exercises.noResults") : t("admin.exercises.noExercises")}
                </p>
              )}
            </div>
          </CardContent>
        </Card>

        {/* Delete Confirmation Dialog */}
        <AlertDialog open={!!deleteExerciseId} onOpenChange={(open) => !open && setDeleteExerciseId(null)}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>{t("admin.exercises.confirmDelete")}</AlertDialogTitle>
              <AlertDialogDescription>
                {t("admin.exercises.confirmDeleteDesc", { name: deleteExerciseName })}
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel>{t("common.cancel")}</AlertDialogCancel>
              <AlertDialogAction
                onClick={handleDelete}
                className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
                disabled={deleteMutation.isPending}
              >
                {deleteMutation.isPending ? (
                  <Loader2 className="h-4 w-4 animate-spin mr-2" />
                ) : null}
                {t("common.delete")}
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </AdminLayout>
  );
}
