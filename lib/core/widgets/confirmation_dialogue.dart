import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/generated/l10n.dart';


// EL Widget de confirmación da opción de aceptar o cancelar. 
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onAccept;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.body,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(S.of(context).cancel),

        ),
        TextButton(

          child: Text(S.of(context).confirm),

          onPressed: () {
            onAccept();
          },
        ),
      ],
    );
  }
}