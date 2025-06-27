import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Color? color;

  const PrimaryButton({
    super.key,
    this.onPressed,
    this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(text ?? S.of(context).continueText),
      ),
    );
  }
}