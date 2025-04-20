import 'package:flutter/material.dart';

class PrimaryTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isSecure;
  const PrimaryTextField(
      {super.key, this.controller, this.hintText, this.isSecure = false});

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  bool obscureText = false;
  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: widget.hintText,
        border: OutlineInputBorder(),
        suffixIcon: widget.isSecure
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: togglePasswordVisibility,
              )
            : null,
      ),
    );
  }
}
