import 'package:flutter/material.dart';

class CustomSubtitle extends StatelessWidget {
  final String text;

  const CustomSubtitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12.0), // margen pequeño a la izquierda
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
