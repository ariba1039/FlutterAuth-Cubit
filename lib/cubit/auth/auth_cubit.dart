import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_flex/models/user_model.dart';
import 'package:flutter_flex/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  late final StreamSubscription<UserModel> _userSubscription;

  AuthCubit({required this.authRepository}) : super(AuthState.unknown()) {
    _userSubscription = authRepository.user.listen((UserModel user) {
      if (user.isNotEmpty) {
        emit(state.copyWith(authStatus: AuthStatus.authenticated, user: user));
      } else {
        emit(state.copyWith(authStatus: AuthStatus.unauthenticated, user: UserModel.empty));
      }
    });
  }

  Future<void> signOut() async {
    await authRepository.logOut();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
