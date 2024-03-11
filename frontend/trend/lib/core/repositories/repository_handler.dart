import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:trend/config/locale/app_localizations.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';

abstract class RepositoryHandler {
  Future<Either<Failure, T>> handle<T>(Future<T> Function() onHandle);
}

class RepositoryHandlerImpl implements RepositoryHandler {
  @override
  Future<Either<Failure, T>> handle<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on MessageException catch (e) {
      return Left(MessageFailure(
          message: e.message ?? "some thing went wrong".hardcoded));
    }
  }
}
