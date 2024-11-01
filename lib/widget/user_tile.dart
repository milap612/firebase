import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.email, required this.onTap});

  final String email;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        email,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
