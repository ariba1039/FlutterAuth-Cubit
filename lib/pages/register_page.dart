import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flex/cubit/register/register_cubit.dart';
import 'package:flutter_flex/utils/auth_utils.dart';
import 'package:flutter_flex/utils/utils.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RegisterCubit registerCubit = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Auth')),
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.submissionInProgress) {
            Utils.showLoader();
          } else if (state.status == RegisterStatus.submissionSuccess) {
            Utils.removeLoader();
            Utils.showSnackBar(context, 'Registered successfully');
          } else if (state.status == RegisterStatus.submissionFailure) {
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
              child: Form(
                key: _formKey,
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
                          if (_formKey.currentState!.validate()) {
                            registerCubit.registerWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        child: Text('Register'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text('Login'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
