import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/constants/strings.dart';
import '../../../../core/utils/errors/exeptions.dart';
import '../../../../core/utils/resources/session_token.dart';
import '../../../../core/utils/resources/supabase.dart';
import '../models/quiz_info_model.dart';
import '../models/quiz_model.dart';
import '../params/quiz_params.dart';

abstract class QuizRemoteDataSource {
  Future<QuizModel> getQuiz({required QuizParams params});

  Future<QuizModel> uploadQuizToDatabase({
    required QuizModel quiz,
    required QuizInfoModel quizInfo,
  });

  Future<void> loadSessionToken();
}

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  final Dio dio;

  QuizRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<QuizModel> getQuiz({
    required QuizParams params,
  }) async {
    final response = await dio.get(
      kBaseUrl,
      queryParameters: {
        'encode': 'base64',
        ...params.toMap(),
      },
    );

    if (response.statusCode == 200) {
      return QuizModel.fromMap(response.data as Map<String, dynamic>);
    } else {
      throw const ServerException();
    }
  }

  /// Upload the quiz with the quiz info to the database and
  /// set update the points
  @override
  Future<QuizModel> uploadQuizToDatabase({
    required QuizModel quiz,
    required QuizInfoModel quizInfo,
  }) async {
    final nickname = supabase.auth.currentUser!.userMetadata?['nickname'] ?? '';
    final userId = supabase.auth.currentUser!.id;

    try {
      // Lookup the user's exam from their profile
      final profile = await supabase
          .from('profiles')
          .select('exam_type')
          .eq('user_id', userId)
          .limit(1)
          .maybeSingle();

      final examType = profile?['exam_type'] as String? ?? 'TYT';

      // Find or use the exam_id corresponding to the user's exam type
      final examRow = await supabase
          .from('exams')
          .select('id')
          .eq('name', examType)
          .limit(1)
          .maybeSingle();

      if (examRow == null) {
        log('No exam found for type: $examType, skipping points recording');
        return quiz;
      }

      final examId = examRow['id'] as String;

      // Record points via the points_ledger table
      await supabase.from('points_ledger').insert({
        'user_id': userId,
        'exam_id': examId,
        'points': quizInfo.totalPoints,
        'reason': 'quiz_completion',
        'ref_type': 'manual',
        'note': 'Quiz: ${quizInfo.name} by $nickname',
      });
    } on PostgrestException catch (e) {
      log(
        "Error with uploadQuizToDatabase: ${e.message}",
      );

      throw ServerException(message: e.message);
    } on TypeError catch (e) {
      log(
        "Error with uploadQuizToDatabase: ${e.toString()}",
      );

      throw ServerException(message: e.toString());
    } catch (e) {
      // If an unexpected error occurs, print the type of the error
      log(
        "Error with uploadQuizToDatabase: $e, Error type: ${e.runtimeType}",
      );
      throw const ServerException();
    }

    return quiz;
  }

  @override
  Future<void> loadSessionToken() async {
    try {
      final response = await dio.get(
        kTokenRequestUrl,
      );

      if (response.statusCode == 200) {
        sessionToken = response.data['token'] as String;
      } else {
        throw const ServerException(message: 'Failed to get session token');
      }
    } catch (e) {
      // If an unexpected error occurs, print the type of the error
      log(
        "Error with getSessionToken: $e, Error type: ${e.runtimeType}",
      );
      throw const ServerException(message: 'Failed to get session token');
    }
  }
}
