import { useState, useEffect } from "react";
import { User, Save, LogOut, Lock, Eye, EyeOff, ChevronDown } from "lucide-react";
import { useAuth } from "@/contexts/AuthContext";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Checkbox } from "@/components/ui/checkbox";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle, AlertDialogTrigger } from "@/components/ui/alert-dialog";
import { useProfile, useUpdateProfile } from "@/hooks/useProfile";
import { toast } from "sonner";
import { cn } from "@/lib/utils";

const AVATAR_CATEGORIES = [
  {
    name: "Спорт",
    emojis: ["💪", "🏋️", "🏃", "🚴", "🏊", "🧘", "🤸", "🏆", "🥇", "🎯", "⚽", "🏀", "🎾", "🥊", "🏈"]
  },
  {
    name: "Крутые",
    emojis: ["😎", "🔥", "⚡", "🚀", "💥", "✨", "👑", "🌟", "💯", "🦾", "🎖️", "💎", "🏅", "⭐", "🔱"]
  },
  {
    name: "Животные",
    emojis: ["🦁", "🐯", "🐺", "🦅", "🦊", "🐻", "🦍", "🐉", "🦈", "🐸", "🦖", "🦏", "🐘", "🦬", "🐗"]
  },
  {
    name: "Смешные",
    emojis: ["🤪", "😜", "🤓", "🥸", "🤡", "👻", "💀", "🎃", "👽", "🤖", "🥴", "😵‍💫", "🫠", "🤯", "🫡"]
  },
  {
    name: "Мемы",
    emojis: ["🗿", "💅", "🤌", "😤", "🙃", "😏", "🫣", "🤭", "😈", "👀", "🤷", "🙈", "🤦", "😬", "🥶"]
  },
  {
    name: "Еда",
    emojis: ["🍕", "🍔", "🌮", "🍣", "🍩", "🍪", "🥑", "🍗", "🥩", "🍺", "🍟", "🌭", "🍦", "🧁", "🍿"]
  },
  {
    name: "Природа",
    emojis: ["🌴", "🌵", "🍀", "🌸", "🌺", "🌻", "🍁", "🌊", "⛰️", "🌙", "☀️", "🌈", "❄️", "🔥", "💧"]
  },
  {
    name: "Техника",
    emojis: ["🎮", "🕹️", "💻", "📱", "🎧", "🎬", "📸", "🔧", "⚙️", "🔌", "💡", "🔋", "📡", "🛸", "🚗"]
  },
  {
    name: "Музыка",
    emojis: ["🎸", "🎹", "🥁", "🎺", "🎻", "🎤", "🎵", "🎶", "🎼", "🪗", "🎷", "📯", "🪕", "🪘", "🎚️"]
  },
  {
    name: "Магия",
    emojis: ["🧙", "🧚", "🧛", "🧜", "🧝", "🦸", "🦹", "🥷", "🧞", "🧟", "🪄", "🔮", "⚗️", "🪬", "🧿"]
  },
  {
    name: "Разное",
    emojis: ["🎭", "🎪", "🎨", "🤘", "🖖", "🦄", "☯️", "♾️", "🎲", "🃏", "🀄", "🧩", "🪅", "🎁", "🧸"]
  }
];

export default function Settings() {
  const { data: profile, isLoading } = useProfile();
  const updateProfile = useUpdateProfile();
  const { signOut, updatePassword } = useAuth();

  const [displayName, setDisplayName] = useState("");
  const [gender, setGender] = useState<"male" | "female" | "other" | "none">("none");
  const [dateOfBirth, setDateOfBirth] = useState("");
  const [height, setHeight] = useState("");
  const [currentWeight, setCurrentWeight] = useState("");
  const [avatar, setAvatar] = useState("");
  const [isSkuf, setIsSkuf] = useState(false);

  // Password change state
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [passwordLoading, setPasswordLoading] = useState(false);
  const [showNewPassword, setShowNewPassword] = useState(false);
  const [passwordSectionOpen, setPasswordSectionOpen] = useState(false);

  // Load profile data when it's available
  useEffect(() => {
    if (profile) {
      setDisplayName(profile.display_name || "");
      setGender(profile.gender || "none");
      setDateOfBirth(profile.date_of_birth || "");
      setHeight(profile.height?.toString() || "");
      setCurrentWeight(profile.current_weight?.toString() || "");
      setAvatar(profile.avatar || "");
      setIsSkuf(profile.is_skuf || false);
    }
  }, [profile]);

  const handleSave = async () => {
    try {
      await updateProfile.mutateAsync({
        display_name: displayName.trim() || null,
        gender: gender === "none" ? null : gender,
        date_of_birth: dateOfBirth || null,
        height: height ? parseFloat(height) : null,
        current_weight: currentWeight ? parseFloat(currentWeight) : null,
        avatar: avatar || null,
        is_skuf: isSkuf,
      });
      toast.success("Профиль обновлен");
    } catch (error) {
      toast.error("Ошибка сохранения профиля");
    }
  };

  const handleChangePassword = async () => {
    if (!newPassword || !confirmPassword) {
      toast.error("Заполните оба поля");
      return;
    }
    if (newPassword.length < 6) {
      toast.error("Пароль должен быть минимум 6 символов");
      return;
    }
    if (newPassword !== confirmPassword) {
      toast.error("Пароли не совпадают");
      return;
    }
    setPasswordLoading(true);
    try {
      await updatePassword(newPassword);
      toast.success("Пароль успешно изменен");
      setNewPassword("");
      setConfirmPassword("");
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : "Ошибка смены пароля";
      toast.error(errorMessage);
    } finally {
      setPasswordLoading(false);
    }
  };

  if (isLoading) {
    return (
      <div className="space-y-6 animate-fade-in">
        <div className="space-y-1">
          <h1 className="text-3xl font-bold bg-gradient-to-r from-foreground to-primary bg-clip-text text-transparent">
            Настройки
          </h1>
          <p className="text-muted-foreground text-base">Загрузка...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6 animate-fade-in">
      <div className="flex items-center gap-4">
        {/* Title and subtitle */}
        <div className="flex-1 space-y-1">
          <h1 className="text-3xl font-bold bg-gradient-to-r from-foreground to-primary bg-clip-text text-transparent">
            Настройки
          </h1>
          <p className="text-muted-foreground text-base">Управление профилем</p>
        </div>

        {/* Logo - Mobile only */}
        <div className="md:hidden">
          <img
            src="/logo.jpg"
            alt="FitTrack Logo"
            className="rounded-lg object-contain"
            style={{ height: '4rem', width: '11rem' }}
          />
        </div>
      </div>

      <Card>
        <CardHeader className="pb-4">
          <CardTitle className="text-lg flex items-center justify-between">
            <div className="flex items-center gap-2">
              <User className="h-5 w-5 text-primary" />
              Профиль
            </div>
            {/* Avatar Selection - Right Side */}
            <Dialog>
              <DialogTrigger asChild>
                <button className="flex items-center justify-center w-16 h-16 rounded-full bg-primary/10 text-4xl hover:bg-primary/20 transition-colors cursor-pointer border-2 border-primary/20">
                  {avatar || "👤"}
                </button>
              </DialogTrigger>
              <DialogContent className="max-w-sm max-h-[80vh] overflow-y-auto">
                <DialogHeader>
                  <DialogTitle>Выбери аватар</DialogTitle>
                </DialogHeader>
                <div className="space-y-4 pt-2">
                  {AVATAR_CATEGORIES.map((category) => (
                    <div key={category.name}>
                      <p className="text-xs font-medium text-muted-foreground mb-2">{category.name}</p>
                      <div className="grid grid-cols-5 gap-2">
                        {category.emojis.map((emoji) => (
                          <button
                            key={emoji}
                            type="button"
                            onClick={() => setAvatar(emoji)}
                            className={cn(
                              "text-2xl p-2.5 rounded-lg transition-all active:scale-95",
                              avatar === emoji
                                ? "bg-primary text-primary-foreground shadow-md ring-2 ring-primary ring-offset-2"
                                : "bg-muted hover:bg-muted/70"
                            )}
                          >
                            {emoji}
                          </button>
                        ))}
                      </div>
                    </div>
                  ))}
                </div>
              </DialogContent>
            </Dialog>
          </CardTitle>
        </CardHeader>
        <CardContent>
            <div className="space-y-4">

          {/* Display Name and Gender */}
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="displayName">Имя</Label>
              <Input
                id="displayName"
                type="text"
                value={displayName}
                onChange={(e) => setDisplayName(e.target.value)}
                placeholder="Введите ваше имя"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="gender">Пол</Label>
              <Select value={gender} onValueChange={(v) => setGender(v as "male" | "female" | "other" | "none")}>
                <SelectTrigger id="gender">
                  <SelectValue placeholder="Выберите пол" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="none">Не указано</SelectItem>
                  <SelectItem value="male">Мужской</SelectItem>
                  <SelectItem value="female">Женский</SelectItem>
                  <SelectItem value="other">Другой</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>

          {/* Date of Birth and Skuf */}
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="dateOfBirth">Дата рождения</Label>
              <Input
                id="dateOfBirth"
                type="date"
                value={dateOfBirth}
                onChange={(e) => setDateOfBirth(e.target.value)}
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="skuf">Скуф</Label>
              <div className="flex items-center h-10 px-3">
                <Checkbox
                  id="skuf"
                  checked={isSkuf}
                  onCheckedChange={(checked) => setIsSkuf(checked as boolean)}
                />
                <label
                  htmlFor="skuf"
                  className="ml-2 text-sm cursor-pointer select-none"
                >
                  {isSkuf ? "Да" : "Нет"}
                </label>
              </div>
            </div>
          </div>

          {/* Height and Weight */}
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2">
              <Label htmlFor="height">Рост (см)</Label>
              <Input
                id="height"
                type="number"
                step="0.1"
                value={height}
                onChange={(e) => setHeight(e.target.value)}
                placeholder="Введите рост"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="currentWeight">Вес (кг)</Label>
              <Input
                id="currentWeight"
                type="number"
                step="0.1"
                value={currentWeight}
                onChange={(e) => setCurrentWeight(e.target.value)}
                placeholder="Введите вес"
              />
            </div>
          </div>

          {/* Save Button */}
          <Button
            onClick={handleSave}
            disabled={updateProfile.isPending}
            className="w-full gap-2"
          >
            <Save className="h-4 w-4" />
            Сохранить
          </Button>
        </div>
        </CardContent>
      </Card>

      {/* Change Password Card - Collapsible */}
      <Collapsible open={passwordSectionOpen} onOpenChange={setPasswordSectionOpen}>
        <Card>
          <CollapsibleTrigger asChild>
            <CardHeader className="pb-4 cursor-pointer hover:bg-muted/50 transition-colors rounded-t-lg">
              <CardTitle className="text-lg flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <Lock className="h-5 w-5 text-primary" />
                  Сменить пароль
                </div>
                <ChevronDown className={cn(
                  "h-5 w-5 text-muted-foreground transition-transform duration-200",
                  passwordSectionOpen && "rotate-180"
                )} />
              </CardTitle>
            </CardHeader>
          </CollapsibleTrigger>
          <CollapsibleContent>
            <CardContent>
              <div className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="newPassword">Новый пароль</Label>
                  <div className="relative">
                    <Input
                      id="newPassword"
                      type={showNewPassword ? "text" : "password"}
                      placeholder="Минимум 6 символов"
                      value={newPassword}
                      onChange={(e) => setNewPassword(e.target.value)}
                      className="pr-10"
                    />
                    <button
                      type="button"
                      onClick={() => setShowNewPassword(!showNewPassword)}
                      className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-foreground transition-colors"
                    >
                      {showNewPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                    </button>
                  </div>
                </div>
                <div className="space-y-2">
                  <Label htmlFor="confirmPassword">Подтвердите пароль</Label>
                  <Input
                    id="confirmPassword"
                    type="password"
                    placeholder="Повторите пароль"
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                  />
                </div>
                <Button
                  onClick={handleChangePassword}
                  disabled={passwordLoading}
                  variant="secondary"
                  className="w-full gap-2"
                >
                  <Lock className="h-4 w-4" />
                  {passwordLoading ? "Сохранение..." : "Изменить пароль"}
                </Button>
              </div>
            </CardContent>
          </CollapsibleContent>
        </Card>
      </Collapsible>

      {/* Logout Button with Confirmation */}
      <AlertDialog>
        <AlertDialogTrigger asChild>
          <Button
            variant="outline"
            className="w-full gap-2 text-destructive hover:text-destructive hover:bg-destructive/10 border-destructive/30"
          >
            <LogOut className="h-4 w-4" />
            Выйти из аккаунта
          </Button>
        </AlertDialogTrigger>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Выйти из аккаунта?</AlertDialogTitle>
            <AlertDialogDescription>
              Вы уверены, что хотите выйти из аккаунта?
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Отмена</AlertDialogCancel>
            <AlertDialogAction
              onClick={signOut}
              className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
            >
              Выйти
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
