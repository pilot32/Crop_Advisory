/// App Theme Configuration
/// 
/// This file defines the app's visual theme including colors, typography,
/// and component styles for both light and dark modes.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// App color palette
class AppColors {
  // Prevent instantiation
  AppColors._();

  // Primary colors - Modern Nature & Tech Theme
  static const Color primary = Color(0xFF2A9D8F); // Soft teal/sage
  static const Color primaryLight = Color(0xFF4DB6AC);
  static const Color primaryDark = Color(0xFF00695C);
  
  // Secondary colors - Soft Earth tones
  static const Color secondary = Color(0xFF8B5A2B);
  static const Color secondaryLight = Color(0xFFBCAAA4);
  static const Color secondaryDark = Color(0xFF5D4037);

  // Accent colors
  static const Color accent = Color(0xFFE9C46A); // Soft Gold/Terracotta
  static const Color accentLight = Color(0xFFF4A261);
  static const Color accentDark = Color(0xFFE76F51);

  // Background colors
  static const Color background = Color(0xFFF8F9FA); // Off-white
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E); // Modern dark charcoal
  
  // Text colors
  static const Color textPrimary = Color(0xFF2B2D42);
  static const Color textSecondary = Color(0xFF8D99AE);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textLight = Color(0xFFFFFFFF);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF29B6F6);

  // Border and divider colors
  static const Color border = Color(0xFFEAEAEA);
  static const Color divider = Color(0xFFEEEEEE);
}

/// App text styles
class AppTextStyles {
  // Prevent instantiation
  AppTextStyles._();

  // Typography Base
  static final TextStyle _baseTextStyle = GoogleFonts.dmSans(
    color: AppColors.textPrimary,
  );

  // Headings
  static final TextStyle h1 = _baseTextStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static final TextStyle h2 = _baseTextStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static final TextStyle h3 = _baseTextStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static final TextStyle h4 = _baseTextStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static final TextStyle h5 = _baseTextStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  // Body text
  static final TextStyle bodyLarge = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static final TextStyle bodyMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static final TextStyle bodySmall = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Alias for body (same as bodyMedium)
  static final TextStyle body = bodyMedium;

  // Special text styles
  static final TextStyle button = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
    letterSpacing: 0.5,
  );

  static final TextStyle caption = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static final TextStyle overline = _baseTextStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 1.5,
  );
}

/// App theme data
class AppTheme {
  // Prevent instantiation
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      // Typography
      textTheme: GoogleFonts.dmSansTextTheme(),

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
        onPrimary: AppColors.textLight,
        onSecondary: AppColors.textLight,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: AppColors.textLight,
      ),

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background, // Match background for a cleaner look
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: AppTextStyles.h4,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          elevation: 0, // Flat buttons
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          side: const BorderSide(color: AppColors.border, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
        labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
      ),

      // Card theme
      cardTheme: const CardThemeData(
        elevation: 0, // Flat cards
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: AppColors.border, width: 1),
        ),
        color: AppColors.surface,
        margin: EdgeInsets.all(8),
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 24,
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // Floating action button theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textLight,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Scaffold background
      scaffoldBackgroundColor: AppColors.background,

      // Use Material 3
      useMaterial3: true,
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      // Typography
      textTheme: GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme),

      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        surface: AppColors.surfaceDark,
        background: Color(0xFF121212),
        error: AppColors.error,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textLight,
        onBackground: AppColors.textLight,
        onError: AppColors.textLight,
      ),

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF121212),
        foregroundColor: AppColors.textLight,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTextStyles.h4.copyWith(color: AppColors.textLight),
      ),

      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: Color(0xFF2A2A2A), width: 1),
        ),
        color: AppColors.surfaceDark,
        margin: EdgeInsets.all(8),
      ),

      // Scaffold background
      scaffoldBackgroundColor: const Color(0xFF121212),

      // Use Material 3
      useMaterial3: true,
    );
  }
}
