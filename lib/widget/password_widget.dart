import 'package:firebase_demo/event/auth_event.dart';
import 'package:firebase_demo/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../state/auth_state.dart';

class PasswordField extends StatelessWidget with Validator {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          icon: Icon(Icons.key),
          hintText: 'Password',
        ),
        validator: (value) => validatePassword(value),
        onChanged: (value) => context.read<AuthBloc>().add(
              PasswordChange(value),
            ),
      );
    });
  }
}
