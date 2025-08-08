import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  final LoginFormState? formState;
  
  const LoginLoading({this.formState});
  
  @override
  List<Object?> get props => [formState];
}

class LoginSuccess extends LoginState {
  const LoginSuccess();
}

class LoginFailure extends LoginState {
  final String errorMessage;
  final LoginFormState? formState;

  const LoginFailure(this.errorMessage, {this.formState});

  @override
  List<Object?> get props => [errorMessage, formState];
}

class LoginFormState extends LoginState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isFormValid;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isFormValid = false,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? isFormValid,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    emailError,
    passwordError,
    isFormValid,
  ];
}
