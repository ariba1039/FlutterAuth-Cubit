import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flex/cubit/register/register_cubit.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'cubit/auth/auth_cubit.dart';
import 'cubit/login/login_cubit.dart';
import 'pages/splash_page.dart';
import 'repository/auth_repository.dart';
import 'utils/theme/light_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseAuth: FirebaseAuth.instance,
            googleSignIn: GoogleSignIn.standard(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<RegisterCubit>(
            create: (context) => RegisterCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Flex',
          debugShowCheckedModeBanner: false,
          builder: BotToastInit(),
          navigatorObservers: [
            BotToastNavigatorObserver(),
          ],
          theme: lightTheme,
          home: const SplashPage(),
        ),
      ),
    );
  }
}
