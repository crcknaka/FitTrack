import { useState } from "react";
import { useTranslation } from "react-i18next";
import { AdminLayout } from "@/components/admin/AdminLayout";
import {
  useEmptyWorkouts,
  useDeleteEmptyWorkouts,
  useOrphanedExercises,
  useDeleteOrphanedExercises,
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
import { Trash2, FileX, Link2Off, Loader2 } from "lucide-react";
import { toast } from "sonner";

export default function AdminCleanup() {
  const { t } = useTranslation();
  const [deleteEmptyDialog, setDeleteEmptyDialog] = useState(false);
  const [deleteOrphanedDialog, setDeleteOrphanedDialog] = useState(false);

  const { data: emptyWorkouts, isLoading: loadingEmpty } = useEmptyWorkouts();
  const { data: orphanedCount, isLoading: loadingOrphaned } = useOrphanedExercises();

  const deleteEmptyMutation = useDeleteEmptyWorkouts();
  const deleteOrphanedMutation = useDeleteOrphanedExercises();

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

  const handleDeleteOrphaned = async () => {
    try {
      const count = await deleteOrphanedMutation.mutateAsync();
      toast.success(t("admin.cleanup.deleted", { count }));
    } catch {
      toast.error(t("common.error"));
    }
    setDeleteOrphanedDialog(false);
  };

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
              <div className="flex items-center justify-between p-4 bg-muted/50 rounded-lg">
                <span className="font-medium">{t("admin.cleanup.found")}</span>
                <span className="text-2xl font-bold">
                  {loadingEmpty ? (
                    <Loader2 className="h-5 w-5 animate-spin" />
                  ) : (
                    emptyWorkouts?.length || 0
                  )}
                </span>
              </div>
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
        </div>

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
      </div>
    </AdminLayout>
  );
}
