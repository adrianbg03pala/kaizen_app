import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00FF41);
  static const Color darkBg = Color(0xFF0A0A0A);
  static const Color darkGrey = Color(0xFF1A1A1A);
  static const Color accentColor = Color(0xFF00FF41);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9A9A9A);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: darkGrey,
        error: Color(0xFFFF6B6B),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkGrey,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      scaffoldBackgroundColor: darkBg,
      cardTheme: CardThemeData(
        color: darkGrey,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkGrey,
        selectedItemColor: primaryColor,
        unselectedItemColor: textSecondary,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: textPrimary, fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: textPrimary, fontSize: 28, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: textPrimary, fontSize: 20, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
          bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: darkBg,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
