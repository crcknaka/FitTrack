import { useTranslation } from "react-i18next";
import { WifiOff, Loader2, CloudOff, Check } from "lucide-react";
import { useOffline } from "@/contexts/OfflineContext";
import { cn } from "@/lib/utils";

export function OfflineIndicator() {
  const { t } = useTranslation();
  const { isOnline, isSyncing, pendingCount } = useOffline();

  // Don't show anything if online and no pending items
  if (isOnline && pendingCount === 0 && !isSyncing) {
    return null;
  }

  return (
    <div
      className={cn(
        "fixed top-0 left-0 right-0 z-[100] py-2 px-4 text-center text-sm font-medium transition-all duration-300",
        "md:left-64", // Account for desktop sidebar
        !isOnline
          ? "bg-destructive/95 text-destructive-foreground"
          : isSyncing
          ? "bg-yellow-500/95 text-yellow-950 dark:text-yellow-50"
          : "bg-primary/95 text-primary-foreground"
      )}
    >
      <div className="flex items-center justify-center gap-2">
        {!isOnline ? (
          <>
            <WifiOff className="h-4 w-4" />
            <span>
              {t("offline.youAreOffline")}. {t("offline.changesWillSync")}
            </span>
          </>
        ) : isSyncing ? (
          <>
            <Loader2 className="h-4 w-4 animate-spin" />
            <span>
              {t("offline.syncing")} {pendingCount}{" "}
              {t("offline.changes")}...
            </span>
          </>
        ) : (
          <>
            <CloudOff className="h-4 w-4" />
            <span>
              {pendingCount} {t("offline.changes")}{" "}
              {t("offline.changesWillSync")}
            </span>
          </>
        )}
      </div>
    </div>
  );
}

// Small badge component for sync status
export function SyncStatusBadge() {
  const { pendingCount, isSyncing } = useOffline();

  if (pendingCount === 0 && !isSyncing) {
    return null;
  }

  return (
    <div
      className={cn(
        "absolute -top-1 -right-1 h-5 min-w-5 px-1 flex items-center justify-center rounded-full text-xs font-bold",
        isSyncing
          ? "bg-yellow-500 text-yellow-950"
          : "bg-primary text-primary-foreground"
      )}
    >
      {isSyncing ? (
        <Loader2 className="h-3 w-3 animate-spin" />
      ) : (
        pendingCount
      )}
    </div>
  );
}

// Icon indicator for unsynced items
export function UnsyncedIndicator({ synced }: { synced: boolean }) {
  const { t } = useTranslation();

  if (synced) {
    return null;
  }

  return (
    <CloudOff
      className="h-4 w-4 text-muted-foreground"
      title={t("offline.notSynced")}
    />
  );
}
