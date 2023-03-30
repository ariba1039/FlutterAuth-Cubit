part of 'register_cubit.dart';

enum RegisterStatus { none, submissionInProgress, submissionSuccess, submissionFailure }



class RegisterState {
  const RegisterState({
    this.status,
    this.errorMessage = '',
  });

  final String errorMessage;
  final RegisterStatus? status;

  RegisterState copyWith({
    RegisterStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}