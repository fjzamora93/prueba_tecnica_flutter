import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 60,
        backgroundColor: AppColors.primary.withOpacity(0.1),
        child: ClipOval(
          child: Image.asset(
            'assets/img/logo.png',
            width: 120,
            height: 120
          ),
        ),
      ),
    );
  }
}