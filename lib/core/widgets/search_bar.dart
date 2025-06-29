import 'package:flutter/material.dart';
import 'package:pruebakidsandclouds/core/theme/app_colors.dart';
import 'package:pruebakidsandclouds/core/helper/responsive_helper.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final bool enabled;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    this.onChanged,
    this.onClear,
    this.controller,
    this.enabled = true,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController _controller;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_handleTextChange);
    }
    super.dispose();
  }

  void _handleTextChange() {
    final hasText = _controller.text.isNotEmpty;
    if (_showClearButton != hasText) {
      setState(() {
        _showClearButton = hasText;
      });
    }
    widget.onChanged?.call(_controller.text);
  }

  void _clearSearch() {
    _controller.clear();
    widget.onClear?.call();
    setState(() {
      _showClearButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveHelper.responsiveValue(context, mobile: 48.0, desktop: 52.0),
      decoration: BoxDecoration(
        color: widget.enabled ? AppColors.white : AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 14.0),
        ),
        border: Border.all(
          color: AppColors.borderFilled.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        enabled: widget.enabled,
        style: TextStyle(
          fontSize: ResponsiveHelper.responsiveValue(context, mobile: 14.0, desktop: 16.0),
          color: widget.enabled ? AppColors.textPrimary : AppColors.textSecondary,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.textSecondary.withOpacity(0.7),
            fontSize: ResponsiveHelper.responsiveValue(context, mobile: 14.0, desktop: 16.0),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: widget.enabled 
                ? AppColors.primary 
                : AppColors.textSecondary.withOpacity(0.5),
            size: ResponsiveHelper.responsiveValue(context, mobile: 20.0, desktop: 22.0),
          ),
          suffixIcon: _showClearButton
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: AppColors.textSecondary,
                    size: ResponsiveHelper.responsiveValue(context, mobile: 18.0, desktop: 20.0),
                  ),
                  onPressed: widget.enabled ? _clearSearch : null,
                  splashRadius: 20,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.responsiveValue(context, mobile: 16.0, desktop: 20.0),
            vertical: ResponsiveHelper.responsiveValue(context, mobile: 12.0, desktop: 16.0),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
