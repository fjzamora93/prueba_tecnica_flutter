/// ResponsiveHelper: Utility class for responsive design decisions
library;

import 'package:flutter/material.dart';

enum ScreenType { mobile, desktop }

class ResponsiveHelper {
  // Breakpoints
  static const double mobileBreakpoint = 768;

  /// Get the current screen type based on width
  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < mobileBreakpoint ? ScreenType.mobile : ScreenType.desktop;
  }

  /// Check if current screen is mobile
  static bool isMobile(BuildContext context) {
    return getScreenType(context) == ScreenType.mobile;
  }

  /// Check if current screen is desktop
  static bool isDesktop(BuildContext context) {
    return getScreenType(context) == ScreenType.desktop;
  }

  /// Get responsive value based on screen type
  static T responsiveValue<T>(
    BuildContext context, {
    required T mobile,
    required T desktop,
  }) {
    return isMobile(context) ? mobile : desktop;
  }

  /// Get responsive padding
  static EdgeInsets responsivePadding(BuildContext context) {
    return EdgeInsets.all(
      responsiveValue(
        context,
        mobile: 16.0,
        desktop: 32.0,
      ),
    );
  }

  /// Get responsive horizontal padding
  static EdgeInsets responsiveHorizontalPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: responsiveValue(
        context,
        mobile: 16.0,
        desktop: 64.0,
      ),
    );
  }

  /// Get responsive content width
  static double getContentWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return responsiveValue(
      context,
      mobile: screenWidth,
      desktop: screenWidth > 1200 ? 1200 : screenWidth * 0.8,
    );
  }

  /// Get responsive grid columns
  static int getGridColumns(BuildContext context) {
    return responsiveValue(
      context,
      mobile: 1,
      desktop: 2,
    );
  }
}
