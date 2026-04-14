import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/errors/exeptions.dart';
import '../../../../core/utils/resources/supabase.dart';
import '../../../../core/services/profile_setup_service.dart';

abstract class AuthenticationRepository {
  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String nickname,
    String examType,
  });
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  static final AuthenticationRepositoryImpl _instance =
      AuthenticationRepositoryImpl._internal();

  factory AuthenticationRepositoryImpl() {
    return _instance;
  }

  AuthenticationRepositoryImpl._internal();

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // After sign-in, ensure profile exists
      final user = supabase.auth.currentUser;
      if (user != null) {
        final nickname =
            user.userMetadata?['nickname'] as String? ??
            email.split('@').first;
        await ProfileSetupService().ensureProfileExists(
          userId: user.id,
          email: email,
          nickname: nickname,
        );
      }
    } on AuthApiException {
      rethrow;
    } catch (e) {
      log("Failed to authenticate: $e, Error type: ${e.runtimeType}");
      rethrow;
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String nickname,
    String examType = 'TYT',
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'nickname': nickname},
      );

      if (response.user != null) {
        await ProfileSetupService().ensureProfileExists(
          userId: response.user!.id,
          email: email,
          nickname: nickname,
          examType: examType,
        );
      }
    } on AuthApiException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e) {
      log("Failed to sign up: $e, Error type: ${e.runtimeType}");
      rethrow;
    }
  }
}
