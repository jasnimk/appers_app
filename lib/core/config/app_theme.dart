import 'package:flutter/material.dart';

class AppTheme {
  // ============================================================
  // BRAND COLOR TOKENS (Do NOT depend on context)
  // ============================================================

  static const Color primaryColor = Color(0xFF8B0000); // Light theme primary
  static const Color primaryDark = Color(0xFF5A0000); // Very deep red
  static const Color primaryLight = Color(0xFFB71C1C); // Bright red
  static const Color secondaryColor = Color(0xFFD4AF37); // Gold
  static const Color accentColor = Color(0xFFFF6F00); // Orange

  // Light Theme Tokens
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Colors.white;
  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF666666);
  static const Color lightPriceColor = Color(0xFF1A1A1A);

  // Dark Theme Tokens
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkSurface = Color(0xFF242424);
  static const Color darkSurfaceVariant = Color(0xFF2E2E2E);
  static const Color darkCardImageBg = Color.fromARGB(255, 134, 130, 130);
  static const Color darkCardInfoBg = Color(0xFF242424);

  static const Color darkTextPrimary = Color(0xFFE8E8E8);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkPriceColor = Color(0xFFFFFFFF);

  static const Color darkAccentRed = Color(0xFFEF5350);
  static const Color darkAccentGold = Color(0xFFFFD54F);

  // ============================================================
  //  THEME-AWARE COLORS (Context-based)
  // ============================================================

  /// 🚀 Automatically chooses the correct primary color
  static Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Color(0xFFFFD54F)
        : primaryColor;
  }

  static Color getTextPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white;
  }

  static Color getTextPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : lightTextPrimary;
  }

  static Color getTextSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextSecondary
        : lightTextSecondary;
  }

  static Color getPriceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkPriceColor
        : lightPriceColor;
  }

  static Color getPriceSecColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 164, 161, 161)
        : const Color.fromARGB(255, 74, 67, 67);
  }

  static Color getAccentColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkAccentRed
        : primaryColor;
  }

  static Color getCardImageBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCardImageBg
        : Colors.white;
  }

  static Color getCardInfoBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCardInfoBg
        : Colors.white;
  }

  // ============================================================
  // LIGHT THEME
  // ============================================================

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
      surface: lightSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: lightTextPrimary,
      onSurfaceVariant: lightTextSecondary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: lightSurface,
      elevation: 0,
      iconTheme: IconThemeData(color: lightTextPrimary),
      titleTextStyle: TextStyle(
        color: lightTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    cardTheme: CardThemeData(
      color: lightSurface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(color: lightTextPrimary),
      displayMedium: TextStyle(color: lightTextPrimary),
      displaySmall: TextStyle(color: lightTextPrimary),
      headlineLarge: TextStyle(color: lightTextPrimary),
      headlineMedium: TextStyle(color: lightTextPrimary),
      headlineSmall: TextStyle(color: lightTextPrimary),
      titleLarge: TextStyle(color: lightTextPrimary),
      titleMedium: TextStyle(color: lightTextPrimary),
      titleSmall: TextStyle(color: lightTextPrimary),
      bodyLarge: TextStyle(color: lightTextPrimary),
      bodyMedium: TextStyle(color: lightTextPrimary),
      bodySmall: TextStyle(color: lightTextSecondary),
      labelLarge: TextStyle(color: lightTextPrimary),
      labelMedium: TextStyle(color: lightTextSecondary),
      labelSmall: TextStyle(color: lightTextSecondary),
    ),
  );

  // ============================================================
  // DARK THEME
  // ============================================================

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: darkAccentRed,
    scaffoldBackgroundColor: darkBackground,

    colorScheme: ColorScheme.dark(
      primary: darkAccentRed,
      secondary: darkAccentGold,
      tertiary: primaryLight,
      surface: darkSurface,
      surfaceContainerHighest: darkSurfaceVariant,
      onPrimary: Colors.white,
      onSecondary: darkBackground,
      onSurface: darkTextPrimary,
      onSurfaceVariant: darkTextSecondary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurface,
      elevation: 0,
      iconTheme: IconThemeData(color: darkTextPrimary),
      titleTextStyle: TextStyle(
        color: darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    cardTheme: CardThemeData(
      color: darkSurface,
      elevation: 4,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkAccentRed,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF3D3D3D)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Color(0xFF3D3D3D)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: darkAccentRed, width: 2),
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(color: darkTextPrimary),
      displayMedium: TextStyle(color: darkTextPrimary),
      displaySmall: TextStyle(color: darkTextPrimary),
      headlineLarge: TextStyle(color: darkTextPrimary),
      headlineMedium: TextStyle(color: darkTextPrimary),
      headlineSmall: TextStyle(color: darkTextPrimary),
      titleLarge: TextStyle(color: darkTextPrimary),
      titleMedium: TextStyle(color: darkTextPrimary),
      titleSmall: TextStyle(color: darkTextPrimary),
      bodyLarge: TextStyle(color: darkTextPrimary),
      bodyMedium: TextStyle(color: darkTextPrimary),
      bodySmall: TextStyle(color: darkTextSecondary),
      labelLarge: TextStyle(color: darkTextPrimary),
      labelMedium: TextStyle(color: darkTextSecondary),
      labelSmall: TextStyle(color: darkTextSecondary),
    ),
  );
}
