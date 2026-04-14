# ExamApp AI 📝

A Flutter-based exam preparation app with Supabase backend integration. Supports multiple exam types (TYT, AYT, etc.), question tracking, mock exams, AI-powered analysis, and a leaderboard system.

## Platform Support
Download for Android from the
[releases page](https://github.com/sbenli10/examapp-ai/releases). You can also run the app in your browser. Windows release is not available at the time.

## Features

- ✅ Authentication (email/password) with Supabase Auth
- ✅ Profile management with nickname, exam type, and avatar
- ✅ Multiple-choice question solving with tracking
- ✅ Mock exams (mini, branch, full)
- ✅ Study plans with daily tasks
- ✅ Points/leaderboard system
- ✅ AI-powered weak topic analysis
- ✅ User-friendly interface

## Database Schema

The app uses the following Supabase/Postgres tables:

| Table | Purpose |
|-------|---------|
| `profiles` | User profiles (nickname, email, exam_type) |
| `user_roles` | User roles (student, admin, moderator) |
| `avatar_configs` | Avatar customization settings |
| `profile_photos` | User profile photos |
| `exams` | Exam definitions (TYT, AYT, etc.) |
| `subjects` | Subjects within exams |
| `topics` | Topics within subjects |
| `questions` | Question bank |
| `question_options` | Answer options for questions |
| `question_attempts` | Individual question attempt records |
| `mock_attempts` | Mock exam attempt records |
| `mock_attempt_questions` | Questions within mock attempts |
| `study_plans` | User study plans |
| `daily_tasks` | Daily task assignments |
| `task_completions` | Task completion records |
| `points_ledger` | Points transaction log |
| `leaderboard_stats` | Aggregated leaderboard statistics |
| `ai_analysis` | AI-generated weak topic analysis |
| `user_progress` | Per-topic progress tracking |
| `user_answers` | Legacy answer records |
| `question_generation_jobs` | AI question generation job tracking |

## Setup

### Prerequisites
- Flutter SDK (≥ 3.3.3)
- A Supabase project with the schema tables created

### 1. Clone the repository

```bash
git clone https://github.com/sbenli10/examapp-ai.git
cd examapp-ai
```

### 2. Configure Supabase credentials

Copy the example environment file and fill in your Supabase project details:

```bash
cp .env.example .env
```

Edit `.env` with your Supabase URL and anon key:

```
SUPABASE_URL=https://your-project-ref.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
```

### 3. Generate environment code

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

This generates `lib/core/utils/env/env.g.dart` from your `.env` file.

### 4. Run the app

```bash
flutter run
```

## Migration Notes

If you're migrating from the previous version of this app:
- The old `users` table has been replaced by `profiles` (with `user_id`, `email`, `exam_type`, `nickname`).
- `username` metadata is now `nickname` to align with the database constraint (`^[a-zA-Z0-9_.]+$`, 3–20 chars).
- Points are now tracked via `points_ledger` instead of a `points` column on the `users` table.
- Quiz data is no longer stored as JSON in the `users` table; instead use `question_attempts` and `mock_attempts`.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](https://github.com/sbenli10/examapp-ai/blob/main/LICENSE)
