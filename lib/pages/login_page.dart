import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flex/cubit/login/login_cubit.dart';
import 'package:flutter_flex/utils/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Login')),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == Status.submissionInProgress) {
            Utils.showLoader();
          } else if (state.status == Status.submissionSuccess) {
            Utils.removeLoader();
            Utils.showSnackBar(context, 'Logged in successfully');
          } else if (state.status == Status.submissionFailure) {
            Utils.removeLoader();
            if (state.errorMessage == 'Null check operator used on a null value') {
              return;
            }
            Utils.showSnackBar(context, state.errorMessage);
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'john@gmail.com',
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: '********',
                      labelText: 'Password  ',
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Login'),
                    ),
                  ),
                  SizedBox(height: 14),
                  Text('Or'),
                  SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<LoginCubit>().loginAnonymously();
                      },
                      child: Text('Anonymous Login'),
                    ),
                  ),
                  SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<LoginCubit>().loginWithGoogle();
                      },
                      child: Text('Login with Google'),
                    ),
                  ),
                  SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<LoginCubit>().loginWithApple();
                      },
                      child: Text('Login with Apple'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
