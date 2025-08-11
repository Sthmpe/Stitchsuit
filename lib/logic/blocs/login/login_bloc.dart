import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginFormState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginReset>(_onReset);
    on<LoginPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final currentState = state;
    if (currentState is LoginFormState) {
      emit(currentState.copyWith(email: event.email));
    }
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final currentState = state;
    if (currentState is LoginFormState) {
      emit(currentState.copyWith(password: event.password));
    }
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final currentState = state;
    if (currentState is LoginFormState) {
      // Emit loading state
      emit(const LoginLoading());

      try {
        // Simulate API call with delay
        await Future.delayed(const Duration(seconds: 2));

        // Mock login logic - you can replace this with actual authentication
        if (currentState.email == 'test@example.com' &&
            currentState.password == 'password123') {
          emit(const LoginSuccess());
        } else {
          emit(const LoginFailure('Invalid email or password'));
          // Revert back to form state to allow user to correct inputs
          emit(currentState);
        }
      } catch (e) {
        emit(LoginFailure('An error occurred: ${e.toString()}'));
        // Ensure the form becomes interactive again after an error
        emit(currentState);
      }
    }
  }

  void _onReset(LoginReset event, Emitter<LoginState> emit) {
    emit(const LoginFormState());
  }

  void _onPasswordVisibilityToggled(
    LoginPasswordVisibilityToggled event,
    Emitter<LoginState> emit,
  ) {
    final currentState = state;
    if (currentState is LoginFormState) {
      emit(
        currentState.copyWith(obscurePassword: !currentState.obscurePassword),
      );
    }
  }
}
