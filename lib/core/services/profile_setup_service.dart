import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/resources/supabase.dart';

/// Service responsible for ensuring required database rows exist
/// for a newly authenticated user (profiles, user_roles, avatar_configs,
/// profile_photos).
class ProfileSetupService {
  static final ProfileSetupService _instance =
      ProfileSetupService._internal();

  factory ProfileSetupService() => _instance;

  ProfileSetupService._internal();

  /// Ensures a row in `profiles` for the given user.
  /// Also ensures defaults in `user_roles`, `avatar_configs`, and
  /// `profile_photos`.
  Future<void> ensureProfileExists({
    required String userId,
    required String email,
    required String nickname,
    String examType = 'TYT',
  }) async {
    try {
      // Upsert profile
      await supabase.from('profiles').upsert(
        {
          'user_id': userId,
          'email': email,
          'exam_type': examType,
          'nickname': nickname,
        },
        onConflict: 'user_id',
      );

      // Ensure user_roles default (student)
      await supabase.from('user_roles').upsert(
        {
          'user_id': userId,
          'role': 'student',
        },
        onConflict: 'user_id',
      );

      // Ensure avatar_configs default
      await supabase.from('avatar_configs').upsert(
        {
          'user_id': userId,
        },
        onConflict: 'user_id',
      );

      // Ensure profile_photos default
      await supabase.from('profile_photos').upsert(
        {
          'user_id': userId,
        },
        onConflict: 'user_id',
      );
    } on PostgrestException catch (e) {
      log('ProfileSetupService error: ${e.message}');
      rethrow;
    } catch (e) {
      log('ProfileSetupService unexpected error: $e');
    }
  }
}
