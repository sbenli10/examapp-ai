import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/errors/exeptions.dart';
import '../../../../core/utils/errors/failure.dart';
import '../data_sources/profile_remote_data_source.dart';

abstract class ProfileRepository {
  Future<Either<Failure, void>> updateProfile({required String nickname});
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> updateProfile(
      {required String nickname}) async {
    try {
      await remoteDataSource.updateProfile(nickname: nickname);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          errorMessage: e.message ?? 'Failed to update profile.',
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          errorMessage: 'Failed to update profile.',
        ),
      );
    }
  }
}
