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
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final currentState = state;
    LoginFormState formState;
    
    if (currentState is LoginFormState) {
      formState = currentState;
    } else if (currentState is LoginFailure && currentState.formState != null) {
      formState = currentState.formState!;
    } else {
      formState = const LoginFormState();
    }
    
    final emailError = _validateEmail(event.email);
    final isFormValid = _isFormValid(
      event.email,
      formState.password,
      emailError,
      formState.passwordError,
    );

    emit(
      formState.copyWith(
        email: event.email,
        emailError: emailError,
        isFormValid: isFormValid,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final currentState = state;
    LoginFormState formState;
    
    if (currentState is LoginFormState) {
      formState = currentState;
    } else if (currentState is LoginFailure && currentState.formState != null) {
      formState = currentState.formState!;
    } else {
      formState = const LoginFormState();
    }
    
    final passwordError = _validatePassword(event.password);
    final isFormValid = _isFormValid(
      formState.email,
      event.password,
      formState.emailError,
      passwordError,
    );

    emit(
      formState.copyWith(
        password: event.password,
        passwordError: passwordError,
        isFormValid: isFormValid,
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final currentState = state;
    LoginFormState formState;
    
    if (currentState is LoginFormState) {
      formState = currentState;
    } else if (currentState is LoginFailure && currentState.formState != null) {
      formState = currentState.formState!;
    } else {
      return; // Can't submit without form state
    }
    
    // Validate form before proceeding
    final emailError = _validateEmail(formState.email);
    final passwordError = _validatePassword(formState.password);

    if (emailError != null || passwordError != null) {
      emit(
        formState.copyWith(
          emailError: emailError,
          passwordError: passwordError,
          isFormValid: false,
        ),
      );
      return;
    }

    // Emit loading state
    emit(LoginLoading(formState: formState));

    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock login logic - you can replace this with actual authentication
      if (formState.email == 'test@example.com' &&
          formState.password == 'password123') {
        emit(const LoginSuccess());
      } else {
        emit(LoginFailure('Invalid email or password', formState: formState));
      }
    } catch (e) {
      emit(LoginFailure('An error occurred: ${e.toString()}', formState: formState));
    }
  }

  void _onReset(LoginReset event, Emitter<LoginState> emit) {
    emit(const LoginFormState());
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
