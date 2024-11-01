import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/bloc/auth_bloc.dart';
import 'package:firebase_demo/main.dart';
import 'package:firebase_demo/screen/signup_page.dart';
import 'package:firebase_demo/screen/users_page.dart';
import 'package:firebase_demo/services/firebase_auth_service.dart';
import 'package:firebase_demo/state/auth_state.dart';
import 'package:firebase_demo/utils/form_submission_status.dart';
import 'package:firebase_demo/widget/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthBloc(
            authService:
                FirebaseAuthService(authService: FirebaseAuth.instance)),
        child: BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.formStatus != current.formStatus,
          listener: (context, state) {
            final formStatus = state.formStatus;
            if (formStatus is FormSuccessStatus) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UsersPage()),
              );
            } else if (formStatus is FormFailStatus) {
              _showSnackBar(context, formStatus.exception.toString());
            }
          },
          child: Center(
            child: Column(
              children: [
                FormWidget(isLogin: true),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()),
                      );
                    },
                    child: const Text('new user?'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
