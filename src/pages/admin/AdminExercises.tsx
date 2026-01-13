import { useTranslation } from "react-i18next";
import { AdminLayout } from "@/components/admin/AdminLayout";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Dumbbell } from "lucide-react";

export default function AdminExercises() {
  const { t } = useTranslation();

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
              {t("admin.exercises.preset")}
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground text-center py-8">
              {t("admin.exercises.comingSoon")}
            </p>
          </CardContent>
        </Card>
      </div>
    </AdminLayout>
  );
}
