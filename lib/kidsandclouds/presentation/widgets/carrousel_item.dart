import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';

class CarouselItem extends StatelessWidget {
  final String imagePath;
  final String title;

  const CarouselItem({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        
        Center(
          child: Image.asset(
            imagePath,
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
       
      ],
    );
  }
}