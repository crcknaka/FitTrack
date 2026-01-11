# После успешного применения миграции в Supabase Dashboard

Выполните этот код в вашем редакторе, чтобы вернуть запрос is_admin из базы данных:

## Файл: src/hooks/useAllProfiles.ts

Замените функцию `useAllProfiles` на:

```typescript
export function useAllProfiles() {
  return useQuery({
    queryKey: ["profiles", "all"],
    queryFn: async () => {
      const { data, error } = await supabase
        .from("profiles")
        .select("user_id, display_name, avatar, is_admin")
        .order("display_name", { ascending: true });

      if (error) throw error;
      return data as UserProfile[];
    },
  });
}
```

Или просто скажите мне "миграция применена" и я сам обновлю код!
