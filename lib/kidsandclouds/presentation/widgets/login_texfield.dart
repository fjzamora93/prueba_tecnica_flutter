import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart'; // Asegúrate de importar el tema


class LoginTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool obscureText;
  final bool isError; 
  final TextEditingController? controller;
  final Widget? suffixIcon;
  const LoginTextField({
    super.key,
    required this.label,
    this.icon,
    required this.obscureText,
    required this.isError,
    this.controller,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final focusNode = FocusNode();

    return StatefulBuilder(
      builder: (context, setState) {
        focusNode.addListener(() {
          setState(() {});
        });
        return ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller!,
          builder: (context, value, child) {
            final bool isFocused = focusNode.hasFocus;
            final bool isFilled = value.text.isNotEmpty;
            final Color fillColor = (isFocused || isFilled)
                ? AppColors.white // Blanco cuando está lleno o en focus
                : AppColors.lightGrey; // Gris claro cuando está vacío
            return TextField(
              controller: controller,
              focusNode: focusNode,
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: label,
                suffixIcon: suffixIcon ?? (icon != null ? Icon(icon) : null),
                filled: true,
                fillColor: fillColor,
                hintStyle: TextStyle(color: theme.hintColor),
                labelStyle: theme.inputDecorationTheme.labelStyle,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color:  Colors.transparent, width: 1), // Borde cuando está lleno
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: AppColors.borderFilled, width: 1), // Borde cuando tiene foco
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
            );
          },
        );
      },
    );
  }
}