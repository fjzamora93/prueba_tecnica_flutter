import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final String? hintText;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.hintText,
    this.suffixIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      enabled: enabled,
      maxLines: maxLines,
      onTap: onTap,
      style: TextStyle(
        fontSize: ResponsiveHelper.responsiveValue(context, mobile: 14.0, desktop: 16.0),
        color: enabled ? AppColors.textPrimary : AppColors.textSecondary,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(
          icon, 
          color: enabled ? AppColors.primary : AppColors.textSecondary,
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0),
          vertical: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 16.0),
        ),
        labelStyle: TextStyle(
          color: enabled ? AppColors.textSecondary : AppColors.labelEmpty,
          fontSize: ResponsiveHelper.responsiveValue(context, mobile: 14.0, desktop: 16.0),
        ),
        hintStyle: TextStyle(
          color: AppColors.labelEmpty,
          fontSize: ResponsiveHelper.responsiveValue(context, mobile: 14.0, desktop: 16.0),
        ),
        filled: !enabled,
        fillColor: enabled ? null : AppColors.backgroundSecondary,
      ),
    );
  }
}
