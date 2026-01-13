# Google Play Data Safety - Ответы для Reppy

Этот документ содержит подготовленные ответы для анкеты Data Safety в Google Play Console.
Используй его при заполнении раздела "App content" → "Data safety".

---

## Общие вопросы

### Does your app collect or share any of the required user data types?
**Yes**

### Is all of the user data collected by your app encrypted in transit?
**Yes** (Supabase использует HTTPS/TLS для всех соединений)

### Do you provide a way for users to request that their data is deleted?
**Yes** (Настройки → Удалить аккаунт)

---

## Data types collected (Типы собираемых данных)

### 1. Personal info

#### Email address
- **Collected**: Yes
- **Shared**: No
- **Required or optional**: Required
- **Purpose**: App functionality, Account management
- **Is this data processed ephemerally?**: No

#### Name (Display name)
- **Collected**: Yes
- **Shared**: No
- **Required or optional**: Optional
- **Purpose**: App functionality, Personalization
- **Is this data processed ephemerally?**: No

#### User IDs (Username)
- **Collected**: Yes
- **Shared**: No
- **Required or optional**: Optional
- **Purpose**: App functionality, Account management
- **Is this data processed ephemerally?**: No

---

### 2. Photos and videos

#### Photos
- **Collected**: Yes
- **Shared**: No (только если пользователь сам создаёт публичную ссылку)
- **Required or optional**: Optional
- **Purpose**: App functionality (фото к тренировкам)
- **Is this data processed ephemerally?**: No

---

### 3. Health and fitness

#### Fitness info (workout data)
- **Collected**: Yes
- **Shared**: No (только если пользователь сам создаёт публичную ссылку или добавляет друзей)
- **Required or optional**: Optional (основной функционал, но можно не заполнять)
- **Purpose**: App functionality
- **Is this data processed ephemerally?**: No

---

### 4. App activity

#### App interactions
- **Collected**: No
- Мы не отслеживаем действия пользователя в аналитических целях

---

### 5. Device or other IDs

- **Collected**: No
- Мы не собираем Device ID, Advertising ID и т.д.

---

## Data NOT collected (Данные которые НЕ собираются)

- Location (Геолокация)
- Contacts (Контакты)
- Calendar (Календарь)
- SMS/Call logs
- Audio/Music files
- Files and docs
- Financial info
- Web browsing history
- Search history
- Installed apps
- Crash logs (мы не используем Crashlytics/Sentry)
- Performance diagnostics
- Device or other IDs
- Advertising ID

---

## Security practices (Практики безопасности)

### Data is encrypted in transit
**Yes** - Все данные передаются через HTTPS

### Data is encrypted at rest
**Yes** - Supabase шифрует данные на сервере

### You can request that data be deleted
**Yes** - Пользователь может удалить аккаунт в настройках

### Data is collected with user consent
**Yes** - Только после регистрации

### Data is handled in compliance with a security standard
**Yes** - Supabase соответствует SOC 2 Type II

---

## Data sharing (Передача данных третьим лицам)

### Is any user data shared with third parties?
**No** - Мы не передаём данные третьим лицам

Исключения (контролируемые пользователем):
- Функция "Поделиться тренировкой" создаёт публичную ссылку
- Функция "Друзья" позволяет другим пользователям видеть тренировки

Это не считается "sharing" в терминах Google, так как инициируется пользователем.

---

## Third-party services used (Используемые сервисы)

### Supabase
- **Purpose**: Backend, Database, Authentication, File storage
- **Data accessed**: Email, name, workout data, photos
- **Privacy Policy**: https://supabase.com/privacy

### Google Sign-In (OAuth)
- **Purpose**: Authentication
- **Data accessed**: Email, name (from Google account)
- **Privacy Policy**: https://policies.google.com/privacy

### Resend (SMTP)
- **Purpose**: Transactional emails (password reset, email confirmation)
- **Data accessed**: Email address only
- **Privacy Policy**: https://resend.com/privacy

---

## Data retention (Хранение данных)

### How long is data retained?
- Data is retained until the user deletes their account
- При удалении аккаунта все данные удаляются безвозвратно

---

## Ссылки для Google Play Console

- **Privacy Policy URL**: https://reppymate.com/privacy
- **Terms of Service URL**: https://reppymate.com/terms

---

## Чек-лист при заполнении

1. [ ] Выбрать все типы данных которые собираются
2. [ ] Для каждого типа указать: collected/shared, purpose, optional/required
3. [ ] Указать что данные шифруются при передаче
4. [ ] Указать что есть возможность удаления данных
5. [ ] Добавить ссылку на Privacy Policy
6. [ ] Проверить и отправить на проверку
