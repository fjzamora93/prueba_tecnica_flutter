import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool obscureText;
  final bool isError;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final int? maxLength;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.icon,
    required this.obscureText,
    required this.isError,
    this.controller,
    this.suffixIcon,
    this.maxLength,
    this.keyboardType,
    this.validator,
    this.errorText,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller!,
          builder: (context, value, child) {
            final bool isFilled = value.text.isNotEmpty;
            final Color fillColor = isFilled
                ? AppColors.white // Blanco cuando está lleno
                : AppColors.backgroundInput ; // Gris claro cuando está vacío
            final Color borderColor = isError ? Colors.red : (isFilled ? AppColors.black  : Colors.transparent);
            final Color labelColor = isError ? Colors.red : (theme.inputDecorationTheme.labelStyle?.color ?? Colors.black);

            return TextField(
              controller: controller,
              obscureText: obscureText,
              maxLength: maxLength,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              onChanged: onChanged,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: theme.inputDecorationTheme.labelStyle?.copyWith(color: labelColor),
                suffixIcon: suffixIcon ?? (icon != null ? Icon(icon) : null),
                filled: true,
                fillColor: fillColor,
                hintStyle: TextStyle(color: theme.hintColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: borderColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: isError ? Colors.red : AppColors.borderFocused, width: 1),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                counterText: '', // Oculta el contador de caracteres
                errorText: isError && (errorText?.isNotEmpty ?? false) ? errorText : null,
                errorStyle: const TextStyle(color: Colors.red, fontSize: 13, overflow: TextOverflow.visible),
                errorMaxLines: 3,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: isError ? Colors.red : AppColors.borderFocused, width: 1),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
} 