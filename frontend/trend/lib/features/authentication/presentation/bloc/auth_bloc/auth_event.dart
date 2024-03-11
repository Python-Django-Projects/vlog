part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEv extends AuthEvent {
  final String email;
  final String password;

  const LoginEv({
    required this.email,
    required this.password,
  });
}

class RegisterEv extends AuthEvent {
  final RegisterFormData formData;

  const RegisterEv({required this.formData});
}
