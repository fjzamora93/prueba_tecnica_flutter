import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';

class EyeVisibilityIcon extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onTap;

  const EyeVisibilityIcon({
    Key? key,
    required this.isVisible,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return IconButton(
      icon: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
        color: AppColors.borderFocused,
      ),
      onPressed: onTap,
      splashRadius: 20,
    );
  }
} 