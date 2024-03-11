import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/config/locale/app_localizations.dart';
import 'package:trend/features/authentication/data/repository/auth_repository.dart';
import '../../../../../core/error/failures.dart';
import '../../../data/models/register_form_data.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<LoginEv>(_onLoginEvent);
    on<RegisterEv>(_onRegisterEvent);
  }

  final AuthRepository authRepository;

  FutureOr<void> _onLoginEvent(LoginEv event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final failureOrSuccess =
        await authRepository.login(event.email, event.password);

    emit(failureOrSuccess.fold(
      (failure) => _mapFailureToState(failure),
      (_) => AuthLoadedState(),
    ));
  }

  FutureOr<void> _onRegisterEvent(
      RegisterEv event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final failureOrSuccess = await authRepository.register(event.formData);
    emit(failureOrSuccess.fold(
      (failure) => _mapFailureToState(failure),
      (_) => AuthLoadedState(),
    ));
  }

  AuthState _mapFailureToState(Failure failure) {
    if (failure is ServerFailure) {
      return AuthErrorState(message: "something went wrong".hardcoded);
    }

    if (failure is MessageFailure) {
      return AuthErrorState(message: failure.message);
    }

    return AuthErrorState(message: "something went wrong".hardcoded);
  }
}
