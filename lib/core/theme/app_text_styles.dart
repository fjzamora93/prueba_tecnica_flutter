import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Clase que contiene todos los estilos de texto de la aplicación
class AppTextStyles {
  AppTextStyles._(); // Constructor privado para evitar instanciación

  static const String fontFamily = 'Mulish';

  /// Texto theme personalizado para la aplicación
  static final TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.mulish(
      textStyle: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    ),
    titleLarge: GoogleFonts.mulish(
      textStyle: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
    ),
    titleMedium: GoogleFonts.mulish(
      textStyle: const TextStyle(
        fontSize: 25,
        color: AppColors.textSubtitle,
      ),
    ),
    titleSmall: GoogleFonts.mulish(
      textStyle: const TextStyle(
        fontSize: 21,
        color: AppColors.textPrimary,
      ),
    ),
    bodyLarge: GoogleFonts.mulish(
      textStyle: const TextStyle(
        fontSize: 17,
        color: AppColors.textInput,
      ),
    ),
    bodyMedium: GoogleFonts.mulish(
      textStyle: const TextStyle(
        fontSize: 14,
        color: AppColors.textSubtitle,
      ),
    ),
    labelLarge: GoogleFonts.mulish(
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),
  );

  // Estilos específicos adicionales si necesitas
  static final TextStyle heading1 = GoogleFonts.mulish(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static final TextStyle heading2 = GoogleFonts.mulish(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle subtitle = GoogleFonts.mulish(
    fontSize: 18,
    color: AppColors.textSubtitle,
  );

  static final TextStyle body = GoogleFonts.mulish(
    fontSize: 17,
    color: AppColors.textInput,
  );

  static final TextStyle caption = GoogleFonts.mulish(
    fontSize: 14,
    color: AppColors.textSubtitle,
  );

  static final TextStyle button = GoogleFonts.mulish(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}
