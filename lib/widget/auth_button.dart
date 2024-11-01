import 'package:firebase_demo/utils/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../event/auth_event.dart';
import '../state/auth_state.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.formKey, required this.isLogin});

  final dynamic formKey;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state.formStatus is FormSubmittingStatus
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if(isLogin){
                      context
                          .read<AuthBloc>()
                          .add(LoginSubmitted(state.username, state.password));
                    }else{
                      context
                          .read<AuthBloc>()
                          .add(RegisterSubmitted(state.username, state.password));
                    }

                  }
                },
                child:  Text(isLogin ? 'Login': 'Register'),
              );
      },
    );
  }
}
