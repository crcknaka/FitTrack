import { memo } from "react";
import { UserMinus, Check, X, Clock } from "lucide-react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";

interface FriendCardProps {
  avatar: string | null;
  displayName: string | null;
  status?: "friend" | "incoming" | "outgoing";
  onRemove?: () => void;
  onAccept?: () => void;
  onReject?: () => void;
  onCancel?: () => void;
  onClick?: () => void;
  isLoading?: boolean;
}

export const FriendCard = memo(function FriendCard({
  avatar,
  displayName,
  status = "friend",
  onRemove,
  onAccept,
  onReject,
  onCancel,
  onClick,
  isLoading,
}: FriendCardProps) {
  const { t } = useTranslation();
  return (
    <div
      className={cn(
        "flex items-center gap-3 p-3 rounded-lg bg-muted/30 transition-colors",
        onClick && "cursor-pointer hover:bg-muted/50"
      )}
      onClick={onClick}
    >
      {/* Avatar */}
      <div className="flex items-center justify-center w-12 h-12 rounded-full bg-primary/10 text-2xl shrink-0">
        {avatar || "👤"}
      </div>

      {/* Name */}
      <div className="flex-1 min-w-0">
        <p className="font-medium text-foreground truncate">
          {displayName || t("common.anonymous")}
        </p>
        {status === "incoming" && (
          <p className="text-xs text-muted-foreground">{t("friends.wantsToAdd")}</p>
        )}
        {status === "outgoing" && (
          <p className="text-xs text-muted-foreground flex items-center gap-1">
            <Clock className="h-3 w-3" />
            {t("friends.waitingForResponse")}
          </p>
        )}
      </div>

      {/* Actions */}
      <div className="flex items-center gap-1 shrink-0" onClick={(e) => e.stopPropagation()}>
        {status === "friend" && onRemove && (
          <Button
            variant="ghost"
            size="icon"
            className="h-8 w-8 text-muted-foreground hover:text-destructive hover:bg-destructive/10"
            onClick={onRemove}
            disabled={isLoading}
          >
            <UserMinus className="h-4 w-4" />
          </Button>
        )}

        {status === "incoming" && (
          <>
            <Button
              variant="ghost"
              size="icon"
              className="h-8 w-8 text-muted-foreground hover:text-green-500 hover:bg-green-500/10"
              onClick={onAccept}
              disabled={isLoading}
            >
              <Check className="h-4 w-4" />
            </Button>
            <Button
              variant="ghost"
              size="icon"
              className="h-8 w-8 text-muted-foreground hover:text-destructive hover:bg-destructive/10"
              onClick={onReject}
              disabled={isLoading}
            >
              <X className="h-4 w-4" />
            </Button>
          </>
        )}

        {status === "outgoing" && onCancel && (
          <Button
            variant="ghost"
            size="icon"
            className="h-8 w-8 text-muted-foreground hover:text-destructive hover:bg-destructive/10"
            onClick={onCancel}
            disabled={isLoading}
          >
            <X className="h-4 w-4" />
          </Button>
        )}
      </div>
    </div>
  );
});
