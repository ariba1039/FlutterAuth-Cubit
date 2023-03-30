import 'package:bloc/bloc.dart';

import '../../exceptions/signup_failure.dart';
import '../../repository/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.authRepository}) : super(RegisterState());

  final AuthRepository authRepository;

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: RegisterStatus.submissionInProgress));
    try {
      await authRepository.registerWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(state.copyWith(status: RegisterStatus.submissionSuccess));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: RegisterStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: RegisterStatus.submissionFailure));
    }
  }
}
