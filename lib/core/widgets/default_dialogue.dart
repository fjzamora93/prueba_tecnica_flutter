import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_button.dart';

class DefaultDialogue extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onContinue;
  final bool isError;

  const DefaultDialogue({
    super.key,
    required this.title,
    required this.message,
    required this.onContinue,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: isError ? AppColors.primary : AppColors.isValidGreen,
            child: Icon(
              isError ? Icons.sentiment_dissatisfied : Icons.check_circle,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            onPressed: onContinue,
          ),
        ],
      ),
    );
  }
}