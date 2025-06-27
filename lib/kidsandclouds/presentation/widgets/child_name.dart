import 'package:flutter/material.dart';

class ChildName extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String title;

  const ChildName({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {


    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstName,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (lastName.isNotEmpty)
                Text(
                  lastName,
                  style: theme.textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        Text(
          title,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}