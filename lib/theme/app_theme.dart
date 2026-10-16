import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData obtenerTema() {
    const fondo = Color(0xFFF4F6FA);
    const principal = Color(0xFF24364B);
    const acento = Color(0xFF4F9D91);

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: fondo,
      colorScheme: ColorScheme.fromSeed(
        seedColor: principal,
        primary: principal,
        secondary: acento,
        surface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: principal,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
