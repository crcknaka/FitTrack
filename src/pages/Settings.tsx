import { useState, useEffect } from "react";
import { Settings as SettingsIcon, User, Save } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useProfile, useUpdateProfile } from "@/hooks/useProfile";
import { toast } from "sonner";

export default function Settings() {
  const { data: profile, isLoading } = useProfile();
  const updateProfile = useUpdateProfile();

  const [displayName, setDisplayName] = useState("");
  const [gender, setGender] = useState<"male" | "female" | "other" | "none">("none");
  const [dateOfBirth, setDateOfBirth] = useState("");
  const [height, setHeight] = useState("");
  const [currentWeight, setCurrentWeight] = useState("");

  // Load profile data when it's available
  useEffect(() => {
    if (profile) {
      setDisplayName(profile.display_name || "");
      setGender(profile.gender || "none");
      setDateOfBirth(profile.date_of_birth || "");
      setHeight(profile.height?.toString() || "");
      setCurrentWeight(profile.current_weight?.toString() || "");
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
      });
      toast.success("Профиль обновлен");
    } catch (error) {
      toast.error("Ошибка сохранения профиля");
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
      <div className="space-y-1">
        <h1 className="text-3xl font-bold bg-gradient-to-r from-foreground to-primary bg-clip-text text-transparent flex items-center gap-2">
          <SettingsIcon className="h-8 w-8" />
          Настройки
        </h1>
        <p className="text-muted-foreground text-base">Управление профилем</p>
      </div>

      <Card>
        <CardHeader className="pb-4">
          <CardTitle className="text-lg flex items-center gap-2">
            <User className="h-5 w-5 text-primary" />
            Профиль
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          {/* Display Name */}
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

          {/* Gender */}
          <div className="space-y-2">
            <Label htmlFor="gender">Пол (опционально)</Label>
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

          {/* Date of Birth */}
          <div className="space-y-2">
            <Label htmlFor="dateOfBirth">Дата рождения</Label>
            <Input
              id="dateOfBirth"
              type="date"
              value={dateOfBirth}
              onChange={(e) => setDateOfBirth(e.target.value)}
            />
          </div>

          {/* Height */}
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

          {/* Current Weight */}
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

          {/* Save Button */}
          <Button
            onClick={handleSave}
            disabled={updateProfile.isPending}
            className="w-full gap-2"
          >
            <Save className="h-4 w-4" />
            Сохранить
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
