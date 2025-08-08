import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
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
      final emailError = _validateEmail(event.email);
      final isFormValid = _isFormValid(
        event.email,
        currentState.password,
        emailError,
        currentState.passwordError,
      );

      emit(
        currentState.copyWith(
          email: event.email,
          emailError: emailError,
          isFormValid: isFormValid,
        ),
      );
    }
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final currentState = state;
    if (currentState is LoginFormState) {
      final passwordError = _validatePassword(event.password);
      final isFormValid = _isFormValid(
        currentState.email,
        event.password,
        currentState.emailError,
        passwordError,
      );

      emit(
        currentState.copyWith(
          password: event.password,
          passwordError: passwordError,
          isFormValid: isFormValid,
        ),
      );
    }
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final currentState = state;
    if (currentState is LoginFormState) {
      // Validate form before proceeding
      final emailError = _validateEmail(currentState.email);
      final passwordError = _validatePassword(currentState.password);

      if (emailError != null || passwordError != null) {
        emit(
          currentState.copyWith(
            emailError: emailError,
            passwordError: passwordError,
            isFormValid: false,
          ),
        );
        return;
      }

      // Keep a snapshot to restore after failure
      final formSnapshot = currentState;

      // Emit loading state
      emit(const LoginLoading());

      try {
        // Simulate API call with delay
        await Future.delayed(const Duration(seconds: 2));

        // Mock login logic - you can replace this with actual authentication
        if (formSnapshot.email == 'test@example.com' &&
            formSnapshot.password == 'password123') {
          emit(const LoginSuccess());
        } else {
          emit(const LoginFailure('Invalid email or password'));
          // Restore form for continued editing
          emit(formSnapshot);
        }
      } catch (e) {
        emit(LoginFailure('An error occurred: ${e.toString()}'));
        // Restore form for continued editing
        emit(formSnapshot);
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
      emit(currentState.copyWith(
        obscurePassword: !currentState.obscurePassword,
      ));
    }
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  bool _isFormValid(
    String email,
    String password,
    String? emailError,
    String? passwordError,
  ) {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        emailError == null &&
        passwordError == null;
  }
}
