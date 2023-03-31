
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flex/exceptions/apple_failure.dart';
import 'package:flutter_flex/exceptions/facebook_failure.dart';

import '../../exceptions/anonymous_failure.dart';
import '../../exceptions/google_failure.dart';
import '../../exceptions/login_failure.dart';
import '../../repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepository}) : super(LoginState());

  final AuthRepository authRepository;

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: LoginStatus.submissionInProgress));
    try {
      await authRepository.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(state.copyWith(status: LoginStatus.submissionSuccess));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: LoginStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.submissionFailure));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.submissionInProgress));
    try {
      await authRepository.loginWithGoogle();
      emit(state.copyWith(status: LoginStatus.submissionSuccess));
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: LoginStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.submissionFailure));
    }
  }

  Future<void> loginWithFacebook() async {
    emit(state.copyWith(status: LoginStatus.submissionInProgress));
    try {
      await authRepository.loginWithFacebook();
      emit(state.copyWith(status: LoginStatus.submissionSuccess));
    } on LogInWithFacebookFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: LoginStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.submissionFailure));
    }
  }

  Future<void> loginWithApple() async {
    emit(state.copyWith(status: LoginStatus.submissionInProgress));
    try {
      await authRepository.loginWithApple();
      emit(state.copyWith(status: LoginStatus.submissionSuccess));
    } on LogInWithAppleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: LoginStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.submissionFailure));
    }
  }

  Future<void> loginAnonymously() async {
    emit(state.copyWith(status: LoginStatus.submissionInProgress));
    try {
      await authRepository.loginAnonymously();
      emit(state.copyWith(status: LoginStatus.submissionSuccess));
    } on LoginAnonymousFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: LoginStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.submissionFailure));
    }
  }

  Future<void> logout() async {
    try {
      await authRepository.logOut();
    } on LogInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: LoginStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.submissionFailure));
    }
  }
}
