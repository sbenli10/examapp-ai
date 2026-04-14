import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/errors/exeptions.dart';
import '../../../../core/utils/resources/supabase.dart';

abstract class ProfileRemoteDataSource {
  Future<void> updateProfile({required String nickname});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<void> updateProfile({required String nickname}) async {
    try {
      // Update the user metadata in Supabase Auth
      await supabase.auth.updateUser(
        UserAttributes(
          data: {'nickname': nickname},
        ),
      );

      // Update the nickname in the profiles table
      await supabase.from('profiles').update({'nickname': nickname}).eq(
        'user_id',
        supabase.auth.currentUser!.id,
      );
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      log(
        "Error with updating profile: $e, Error type: ${e.runtimeType}",
      );
      throw const ServerException();
    }
  }
}
