import { useTranslation } from "react-i18next";
import { AdminLayout } from "@/components/admin/AdminLayout";
import { useAdminStats } from "@/hooks/admin/useAdminStats";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  Users,
  Activity,
  Calendar,
  Dumbbell,
  TrendingUp,
  Trophy,
} from "lucide-react";
import { Skeleton } from "@/components/ui/skeleton";

function StatCard({
  title,
  value,
  icon: Icon,
  description,
}: {
  title: string;
  value: string | number;
  icon: React.ElementType;
  description?: string;
}) {
  return (
    <Card>
      <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
        <CardTitle className="text-sm font-medium">{title}</CardTitle>
        <Icon className="h-4 w-4 text-muted-foreground" />
      </CardHeader>
      <CardContent>
        <div className="text-2xl font-bold">{value}</div>
        {description && (
          <p className="text-xs text-muted-foreground">{description}</p>
        )}
      </CardContent>
    </Card>
  );
}

function StatCardSkeleton() {
  return (
    <Card>
      <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
        <Skeleton className="h-4 w-24" />
        <Skeleton className="h-4 w-4" />
      </CardHeader>
      <CardContent>
        <Skeleton className="h-8 w-16 mb-1" />
        <Skeleton className="h-3 w-32" />
      </CardContent>
    </Card>
  );
}

export default function AdminDashboard() {
  const { t } = useTranslation();
  const { data: stats, isLoading } = useAdminStats();

  return (
    <AdminLayout>
      <div className="space-y-6">
        <div>
          <h1 className="text-2xl font-bold">{t("admin.nav.dashboard")}</h1>
          <p className="text-muted-foreground">{t("admin.dashboardDesc")}</p>
        </div>

        {/* Stats Grid */}
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {isLoading ? (
            <>
              <StatCardSkeleton />
              <StatCardSkeleton />
              <StatCardSkeleton />
              <StatCardSkeleton />
              <StatCardSkeleton />
              <StatCardSkeleton />
            </>
          ) : (
            <>
              <StatCard
                title={t("admin.stats.totalUsers")}
                value={stats?.totalUsers || 0}
                icon={Users}
              />
              <StatCard
                title={t("admin.stats.activeUsers7d")}
                value={stats?.activeUsers7d || 0}
                icon={Users}
                description={t("admin.stats.last7days")}
              />
              <StatCard
                title={t("admin.stats.activeUsers30d")}
                value={stats?.activeUsers30d || 0}
                icon={Users}
                description={t("admin.stats.last30days")}
              />
              <StatCard
                title={t("admin.stats.totalWorkouts")}
                value={stats?.totalWorkouts || 0}
                icon={Activity}
              />
              <StatCard
                title={t("admin.stats.workoutsToday")}
                value={stats?.workoutsToday || 0}
                icon={Calendar}
              />
              <StatCard
                title={t("admin.stats.avgWorkoutsPerUser")}
                value={stats?.avgWorkoutsPerUser || 0}
                icon={TrendingUp}
              />
            </>
          )}
        </div>

        {/* Top Exercises */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Trophy className="h-5 w-5" />
              {t("admin.stats.topExercises")}
            </CardTitle>
          </CardHeader>
          <CardContent>
            {isLoading ? (
              <div className="space-y-3">
                {[...Array(5)].map((_, i) => (
                  <div key={i} className="flex items-center justify-between">
                    <Skeleton className="h-4 w-48" />
                    <Skeleton className="h-4 w-12" />
                  </div>
                ))}
              </div>
            ) : stats?.topExercises && stats.topExercises.length > 0 ? (
              <div className="space-y-3">
                {stats.topExercises.map((exercise, index) => (
                  <div
                    key={index}
                    className="flex items-center justify-between py-2 border-b border-border/50 last:border-0"
                  >
                    <div className="flex items-center gap-3">
                      <span className="text-sm font-medium text-muted-foreground w-6">
                        #{index + 1}
                      </span>
                      <Dumbbell className="h-4 w-4 text-primary" />
                      <span className="font-medium">{exercise.name}</span>
                    </div>
                    <span className="text-sm text-muted-foreground">
                      {exercise.count} {t("admin.stats.uses")}
                    </span>
                  </div>
                ))}
              </div>
            ) : (
              <p className="text-muted-foreground text-center py-4">
                {t("common.noData")}
              </p>
            )}
          </CardContent>
        </Card>
      </div>
    </AdminLayout>
  );
}
