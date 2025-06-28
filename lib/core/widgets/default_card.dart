import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';



/**
 * Componente Card que incluye los siguientes elementos:
 * - Un inkwell para recibir eventos de tap
 * - Un card que hereda sus valores de Theme.of(context).cardTheme
 * - Un padding opcional
 * - Un elevation opcional
 */
class DefaultCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final String? title;
  final Color? backgroundColor;

  const DefaultCard({
    super.key,
    required this.child,
    this.onTap,
    this.title,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardTheme = theme.cardTheme;
    final shape = cardTheme.shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(6));
    final padding = EdgeInsets.all(16.0);

    BorderRadius? inkWellBorderRadius;
    if (shape is RoundedRectangleBorder) {
      inkWellBorderRadius = shape.borderRadius as BorderRadius?;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        if (title != null && title!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            child: Text(
              title!,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          
        Material(
          elevation: cardTheme.elevation ?? 0,
          shape: shape,
          color: backgroundColor ?? AppColors.white,
          child: InkWell(
            onTap: onTap,
            borderRadius: inkWellBorderRadius,
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}