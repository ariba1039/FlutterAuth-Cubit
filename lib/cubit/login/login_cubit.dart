import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flex/exceptions/apple_failure.dart';

import '../../exceptions/anonymous_failure.dart';
import '../../exceptions/google_failure.dart';
import '../../exceptions/login_failure.dart';
import '../../repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepository}) : super(LoginState());

  final AuthRepository authRepository;

  Future<void> logInWithCredentials(String email, String password) async {
    emit(state.copyWith(status: Status.submissionInProgress));
    try {
      await authRepository.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(state.copyWith(status: Status.submissionSuccess));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: Status.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.submissionFailure));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: Status.submissionInProgress));
    try {
      await authRepository.loginWithGoogle();
      emit(state.copyWith(status: Status.submissionSuccess));
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: Status.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.submissionFailure));
    }
  }
  Future<void> loginWithApple() async {
    emit(state.copyWith(status: Status.submissionInProgress));
    try {
      await authRepository.loginWithApple();
      emit(state.copyWith(status: Status.submissionSuccess));
    } on LogInWithAppleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: Status.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.submissionFailure));
    }
  }

  Future<void> loginAnonymously() async {
    emit(state.copyWith(status: Status.submissionInProgress));
    try {
      await authRepository.loginAnonymously();
      emit(state.copyWith(status: Status.submissionSuccess));
    } on LoginAnonymousFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: Status.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.submissionFailure));
    }
  }

  Future<void> logout() async {
    try {
      await authRepository.logOut();
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: Status.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.submissionFailure));
    }
  }
}
