import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/widgets/custom_textfield.dart';
import 'package:pruebakidsandclouds/core/widgets/eye_visibility_icon.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';


class PasswordFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool isError;
  final String? label;
  final String? errorText;
  const PasswordFieldWidget({required this.controller, required this.isError, this.errorText, this.label, Key? key}) : super(key: key);

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: widget.label ?? S.of(context).password,
      obscureText: !_passwordVisible,
      controller: widget.controller,
      isError: false,
      errorText: null,
      suffixIcon: EyeVisibilityIcon(
        isVisible: _passwordVisible,
        onTap: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      ),
    );
  }
} 