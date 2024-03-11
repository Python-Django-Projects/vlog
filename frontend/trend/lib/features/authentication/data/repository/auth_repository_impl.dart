import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/repositories/repository_handler.dart';
import '../../../../core/utils/shared_pref.dart';
import '../data_source/auth_remote_data_source.dart';
import '../models/register_form_data.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final SharedPref sharedPref;
  final NetworkInfo networkInfo;
  final RepositoryHandler repositoryHandler;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.networkInfo,
    required this.sharedPref,
    required this.repositoryHandler,
  });

  @override
  Future<Either<Failure, Unit>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      return repositoryHandler.handle<Unit>(
        () async {
          final user = await authRemoteDataSource.login(email, password);
          sharedPref.login(user);
          return unit;
        },
      );
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> register(RegisterFormData formData) async {
    if (await networkInfo.isConnected) {
      return repositoryHandler.handle<Unit>(
        () async {
          await authRemoteDataSource.register(formData);
          return unit;
        },
      );
    } else {
      return Left(CacheFailure());
    }
  }
}
