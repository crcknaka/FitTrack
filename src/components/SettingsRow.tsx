import { LucideIcon } from "lucide-react";
import { cn } from "@/lib/utils";

type ColorVariant =
  | "primary" | "blue" | "green" | "red" | "orange" | "amber"
  | "yellow" | "purple" | "pink" | "cyan" | "emerald" | "indigo";

const colorClasses: Record<ColorVariant, { bg: string; text: string }> = {
  primary: { bg: "bg-primary/10", text: "text-primary" },
  blue: { bg: "bg-blue-500/10", text: "text-blue-500" },
  green: { bg: "bg-green-500/10", text: "text-green-500" },
  red: { bg: "bg-red-500/10", text: "text-red-500" },
  orange: { bg: "bg-orange-500/10", text: "text-orange-500" },
  amber: { bg: "bg-amber-500/10", text: "text-amber-500" },
  yellow: { bg: "bg-yellow-500/10", text: "text-yellow-500" },
  purple: { bg: "bg-purple-500/10", text: "text-purple-500" },
  pink: { bg: "bg-pink-500/10", text: "text-pink-500" },
  cyan: { bg: "bg-cyan-500/10", text: "text-cyan-500" },
  emerald: { bg: "bg-emerald-500/10", text: "text-emerald-500" },
  indigo: { bg: "bg-indigo-500/10", text: "text-indigo-500" },
};

interface SettingsRowProps {
  icon: LucideIcon;
  color: ColorVariant;
  label: string;
  description?: string;
  children: React.ReactNode;
  noBorder?: boolean;
  className?: string;
}

export function SettingsRow({
  icon: Icon,
  color,
  label,
  description,
  children,
  noBorder = false,
  className,
}: SettingsRowProps) {
  const colors = colorClasses[color];

  return (
    <div
      className={cn(
        "flex items-center gap-3 py-3",
        !noBorder && "border-b border-border/50",
        className
      )}
    >
      <div className={cn("flex items-center justify-center w-9 h-9 rounded-lg", colors.bg)}>
        <Icon className={cn("h-4 w-4", colors.text)} />
      </div>
      <div className="flex-1 min-w-0">
        <p className="text-sm font-medium">{label}</p>
        {description && (
          <p className="text-xs text-muted-foreground">{description}</p>
        )}
      </div>
      {children}
    </div>
  );
}
