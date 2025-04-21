import 'package:chat/core/utils/empty_space.dart';
import 'package:chat/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ReggisterScreen extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const ReggisterScreen(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFields.primaryTextField(
          controller: emailController,
          hintText: 'Email',
        ),
        16.h,
        TextFields.primaryTextField(
          controller: passwordController,
          hintText: 'Password',
          isSecure: true,
        ),
        16.h,
        TextFields.primaryTextField(
          controller: confirmPasswordController,
          hintText: 'Confirm Password',
          isSecure: true,
        ),
        16.h,
      ],
    );
  }
}
