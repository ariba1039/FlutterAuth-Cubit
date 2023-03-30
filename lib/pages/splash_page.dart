import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flex/cubit/auth/auth_cubit.dart';
import 'package:flutter_flex/pages/login_page.dart';

import 'home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.authStatus == AuthStatus.authenticated) {
          return HomeScreen();
        } else if (state.authStatus == AuthStatus.unauthenticated) {
          return LoginPage();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
