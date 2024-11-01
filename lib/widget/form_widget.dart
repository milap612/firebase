import 'package:firebase_demo/widget/password_widget.dart';
import 'package:firebase_demo/widget/username_widget.dart';
import 'package:flutter/material.dart';

import 'auth_button.dart';

class FormWidget extends StatelessWidget {
  FormWidget({super.key, required this.isLogin});

  final formKey = GlobalKey();
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const UsernameField(),
          const PasswordField(),
          const SizedBox(height: 15),
          AuthButton(
            formKey: formKey,
            isLogin: isLogin,
          )
        ],
      ),
    );
  }
}
