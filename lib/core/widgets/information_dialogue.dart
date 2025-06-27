
import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';
import 'package:pruebakidsandclouds/core/widgets/primary_button.dart';



class InformationDialogue extends StatelessWidget {
  final String title;
  final String textBody;
  final VoidCallback onContinue;
  final bool isError;

  const InformationDialogue({
    super.key,
    this.title = "",
    this.textBody = "",
    required this.onContinue,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    // Mensajes automáticos si hay error
    final displayTitle = isError ? "": title;
    final displayTextBody = isError ? S.of(context).error : textBody;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: isError ? Colors.red.shade100 : Colors.green.shade100,
              child: isError
                  ? Icon(Icons.sentiment_dissatisfied, color: AppColors.primary, size: 40)
                  : Icon(Icons.check, color: AppColors.isValidGreen, size: 40),
            ),


            if (title.isNotEmpty) SizedBox(height: 24),
            if (title.isNotEmpty) Text(
              displayTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.black,),
              textAlign: TextAlign.center,
            ),

            if (displayTextBody.isNotEmpty)const SizedBox(height: 16),
            if (displayTextBody.isNotEmpty) Text(
              displayTextBody,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 28),

            // BOTÓN DE CONTINUAR
            PrimaryButton(
              onPressed: onContinue,
              color: AppColors.primary
            ),

       
          ],
        ),
      ),
    );
  }
}