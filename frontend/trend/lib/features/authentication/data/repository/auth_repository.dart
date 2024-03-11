import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../models/register_form_data.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login(
    String email,
    String password,
  );
  Future<Either<Failure, Unit>> register(RegisterFormData formData);
}
