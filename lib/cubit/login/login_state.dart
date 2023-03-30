part of 'login_cubit.dart';

enum LoginStatus { none, submissionInProgress, submissionSuccess, submissionFailure }

class LoginState {
  const LoginState({
    this.status,
    this.errorMessage = '',
  });

  final String errorMessage;
  final LoginStatus? status;

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
