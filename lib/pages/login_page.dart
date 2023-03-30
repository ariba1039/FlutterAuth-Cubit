import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flex/cubit/login/login_cubit.dart';
import 'package:flutter_flex/pages/register_page.dart';
import 'package:flutter_flex/utils/auth_utils.dart';
import 'package:flutter_flex/utils/utils.dart';

import '../utils/animations/fade_animation.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginCubit loginCubit = context.read<LoginCubit>();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: Text('Firebase Auth')),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.submissionInProgress) {
              Utils.showLoader();
            } else if (state.status == LoginStatus.submissionSuccess) {
              Utils.removeLoader();
              Utils.showSnackBar(context, 'Logged in successfully');
            } else if (state.status == LoginStatus.submissionFailure) {
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
                child: FadeInUpAnimation(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autoValidateMode,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          validator: (val) => AuthUtils.validateEmail(val),
                          decoration: InputDecoration(
                            hintText: 'john@gmail.com',
                            labelText: 'Email',
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          validator: (val) => AuthUtils.validatePassword(val),
                          decoration: InputDecoration(
                            hintText: '********',
                            labelText: 'Password',
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _autoValidateMode = AutovalidateMode.always;
                              if (_formKey.currentState!.validate()) {
                                loginCubit.logInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            child: Text('Login'),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('New User? '),
                            TextButton(
                              style: TextButton.styleFrom(padding: EdgeInsets.zero),
                              child: Text('Register'),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage()));
                              },
                            ),
                          ],
                        ),
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
          ),
        ),
      ),
    );
  }
}
