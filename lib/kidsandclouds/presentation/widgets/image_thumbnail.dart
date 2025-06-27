import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';

class ImageThumbnail extends StatelessWidget {
  final String imageUrl;
  final double size;
  final bool isCircular;
  final Widget? fallbackIcon;

  const ImageThumbnail({
    super.key,
    required this.imageUrl,
    this.size = 50,
    this.isCircular = true,
    this.fallbackIcon,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = Image.network(
      imageUrl,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircular ? null : BorderRadius.circular(8),
          ),
          child: fallbackIcon ?? 
                 Icon(
                   Icons.person, 
                   color: AppColors.white,
                   size: size * 0.6,
                 ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.lightGrey.withOpacity(0.3),
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircular ? null : BorderRadius.circular(8),
          ),
          child: Center(
            child: SizedBox(
              width: size * 0.4,
              height: size * 0.4,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          ),
        );
      },
    );

    if (isCircular) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: imageWidget,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: imageWidget,
    );
  }
}