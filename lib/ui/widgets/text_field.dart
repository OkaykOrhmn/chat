import 'package:flutter/material.dart';

class TextFields {
  static Widget primaryTextField({
    TextEditingController? controller,
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isSecure = false,
    void Function(String)? onChanged,
  }) {
    return _PrimaryTextField(
      controller: controller,
      hintText: hintText,
      isSecure: isSecure,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      onChanged: onChanged,
    );
  }

  static Widget multilineTextField({
    TextEditingController? controller,
    required String hintText,
    int minLines = 4,
    void Function(String)? onChanged,
  }) {
    return _MultilineTextField(
      controller: controller,
      hintText: hintText,
      minLines: minLines,
      onChanged: onChanged,
    );
  }
}

class _PrimaryTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isSecure;
  final void Function(String)? onChanged;

  const _PrimaryTextField({
    this.controller,
    required this.hintText,
    this.isSecure = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  State<_PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<_PrimaryTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isSecure;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isSecure ? _obscureText : false,
      onChanged: widget.onChanged,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        labelText: widget.hintText,
        border: const OutlineInputBorder(),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isSecure
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : widget.suffixIcon,
      ),
    );
  }
}

class _MultilineTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final int minLines;
  final void Function(String)? onChanged;

  const _MultilineTextField({
    this.controller,
    required this.hintText,
    this.minLines = 4,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: null,
      minLines: minLines,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        labelText: hintText,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
