import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';

class ErrorStateWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;
  final String? retryButtonText;
  final IconData? errorIcon;
  final double? height;

  const ErrorStateWidget({
    super.key,
    required this.errorMessage,
    this.onRetry,
    this.retryButtonText = 'Reintentar',
    this.errorIcon = Icons.error_outline,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          errorIcon!,
          size: ResponsiveHelper.responsiveValue(context, mobile: 64.0, desktop: 80.0),
          color: AppColors.error,
        ),
        SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0)),
        
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 24.0),
          ),
          child: Text(
            errorMessage,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 18.0),
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        
        if (onRetry != null) ...[
          SizedBox(height: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0)),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.responsiveValue(context, mobile: 24.0, desktop: 32.0),
                vertical: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 16.0),
              ),
            ),
            child: Text(
              retryButtonText!,
              style: TextStyle(
                fontSize: ResponsiveHelper.responsiveValue(context, mobile: 14.0, desktop: 16.0),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );

    // Si se especifica una altura, usar un Container con esa altura
    if (height != null) {
      return SizedBox(
        height: height,
        child: Center(child: content),
      );
    }

    // Si no se especifica altura, usar Center normal
    return Center(child: content);
  }
}