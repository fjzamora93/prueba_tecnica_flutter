import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';

class CustomLoadingIndicator extends StatefulWidget {
  final double size;
  final double strokeWidth;
  final Color? color;
  final String? message;

  const CustomLoadingIndicator({
    super.key,
    this.size = 40,
    this.strokeWidth = 3,
    this.color = AppColors.primary,
    this.message,
  });

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30),
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: CircularProgressIndicator(
              strokeWidth: widget.strokeWidth,
              color: widget.color ?? AppColors.primary,
              backgroundColor: AppColors.lightGrey.withOpacity(0.3),
            ),
          ),
          if (widget.message != null) ...[
            const SizedBox(height: 12),
            FadeTransition(
              opacity: _controller,
              child: Text(
                widget.message!,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}