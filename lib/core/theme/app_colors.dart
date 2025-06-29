import 'package:flutter/material.dart';

/// Clase que contiene todos los colores de la aplicación (muchos no se van a utilizar, pero está bien tenerlos controlados desde el principio)
class AppColors {
  AppColors._(); // Constructor privado para evitar instanciación

  // COLORES PRINCIPALES
  static const Color primary = Color(0xFFFF6F61); // Coral
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // COLORES DE ESTADO
  static const Color success = Color(0xFFC8EDD9); // Verde claro
  static const Color isValidGreen = Color(0xFF62AF8A); // Verde
  static const Color error = Colors.redAccent;

  // COLORES DE TEXTO
  static const Color textPrimary = Color(0xFF34495E); // Gris oscuro
  static const Color textSecondary = Color(0xFF6E7A8A); // Gris medio
  static const Color textInput = Color(0xFF272727);
  static const Color textSubtitle = Color(0xFF6E7A8A);

  // COLORES DE FONDO
  static const Color backgroundPrimary = Color(0xFFF8F8F8); // Gris muy claro
  static const Color backgroundSecondary = Color(0xFFFAFAFA); // Gris claro
  static const Color backgroundTertiary = Color.fromARGB(255, 250, 175, 175); // Gris medio
  static const Color backgroundInput = Color.fromARGB(255, 247, 243, 243); // Blanco

  // COLORES DE BORDE
  static const Color borderFilled = Color(0xFF909090);
  static const Color borderFocused = Color(0xFFC5C5C5);

  // COLORES DE BOTÓN
  static const Color buttonDisabled = Color(0xFFFCC8C5);
  static const Color buttonDisabledText = Color(0xFF561411);

  // COLORES TEMÁTICOS (Gold/Green/Blue)
  static const Color gold = Color(0xFFF2CFA0);
  static const Color lightGold = Color(0xFFF7E8D7);
  static const Color orangeGold = Color(0xFFEFB96A);
  static const Color darkGreen = Color(0xFF163F2A);
  static const Color darkBlue = Color(0xFF192835);

  // COLORES ADICIONALES
  static const Color circle = Color(0xFFBEDDEA);
  static const Color labelEmpty = Color(0xFF7E7E7E);
  static const Color lightGrey = Color(0xFFD7D7D7);
}
