import 'package:chat/core/utils/empty_space.dart';
import 'package:chat/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginScreen(
      {super.key,
      required this.emailController,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTextField(
          controller: emailController,
          hintText: 'Email',
        ),
        16.h,
        PrimaryTextField(
          controller: passwordController,
          hintText: 'Password',
          isSecure: true,
        ),
        16.h,
      ],
    );
  }
}
