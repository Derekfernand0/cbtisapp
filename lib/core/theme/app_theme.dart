import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Paleta de colores principal
  static const Color burgundy = Color(0xFF7A1B38); // Borgoña elegante
  static const Color white = Colors.white;
  static const Color background =
      Color(0xFFF8F9FA); // Blanco roto para el fondo
  static const Color textDark = Color(0xFF2D3142);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: burgundy,
        primary: burgundy,
        secondary: burgundy.withOpacity(0.8),
        background: background,
        surface: white,
      ),
      // Usamos Google Fonts para darle un toque moderno y limpio
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge:
            GoogleFonts.poppins(color: burgundy, fontWeight: FontWeight.bold),
        bodyLarge: GoogleFonts.poppins(color: textDark),
        bodyMedium: GoogleFonts.poppins(color: textDark),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: burgundy,
        foregroundColor: white,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: burgundy,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // Estilo WhatsApp
        elevation: 8,
      ),
    );
  }
}
