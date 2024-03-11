import 'package:dartz/dartz.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/api/generate_response_error_message.dart';
import '../../../../core/error/exceptions.dart';
import '../models/register_form_data.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(
    String email,
    String password,
  );
  Future<Unit> register(RegisterFormData formData);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;
  AuthRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await apiConsumer.post(EndPoints.login, body: {
      "email": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      final UserModel user = UserModel(
        id: 0,
        firstName: "",
        lastName: "",
        image: "",
        email: "",
        accessToken: response.data['access'],
        refreshToken: response.data['refresh'],
      );
      return Future.value(user);
    } else if (response.statusCode == 401) {
      throw MessageException(message: response.data['detail']);
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<Unit> register(RegisterFormData formData) async {
    final response = await apiConsumer.post(EndPoints.register, body: {
      "username": formData.username,
      "email": formData.email,
      "password": formData.password,
      "password2": formData.password,
    });
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else if (response.statusCode == 400) {
      final errorMessage = generateResponseErrorMessage(response.data);
      print(errorMessage);
      throw MessageException(message: errorMessage);
    } else {
      throw const ServerException();
    }
  }
}
