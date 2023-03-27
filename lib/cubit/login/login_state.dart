part of 'login_cubit.dart';

enum Status { none, submissionInProgress, submissionSuccess, submissionFailure }

class LoginState {
  const LoginState({
    this.errorMessage = '',
    this.status,
  });

  final String errorMessage;
  final Status? status;

  LoginState copyWith({
    Status? status,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
