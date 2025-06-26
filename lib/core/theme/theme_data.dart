import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// Tema principal de la aplicación
final ThemeData appTheme = ThemeData(
  fontFamily: AppTextStyles.fontFamily,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.backgroundInput,
  textTheme: AppTextStyles.textTheme,
  
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    ),
  ),
  
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      side: const BorderSide(color: AppColors.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
  ),
  
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.focused) || 
          states.contains(MaterialState.hovered)) {
        return AppColors.backgroundInput;
      }
      return AppColors.backgroundPrimary;
    }),
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.borderFocused, width: 1),
    ),
    hintStyle: const TextStyle(color: AppColors.labelEmpty),
    labelStyle: const TextStyle(color: AppColors.labelEmpty),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.borderFocused, width: 1),
    ),
  ),
  
  cardTheme: CardTheme(
    color: AppColors.backgroundTertiary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    margin: EdgeInsets.zero,
    elevation: 1.0,
  ),
  
  iconTheme: const IconThemeData(
    color: AppColors.primary,
    size: 24,
  ),
  
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.white,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textSubtitle,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),
  
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.primary,
    surface: AppColors.white,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.textPrimary,
    error: AppColors.error,
  ).copyWith(surface: AppColors.backgroundPrimary),
);
