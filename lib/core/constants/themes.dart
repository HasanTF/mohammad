import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFD8D2FE);
  static const Color secondary = Color(0xFFF6D1C1);
  static const Color background = Color(0xFFFFF8F6);
  static const Color textPrimary = Color(0xFF4A4A4A);
  static const Color textSecondary = Color(0xC78B6B7B);
  static const Color borders = Color(0xFFF0DDE5);
  static const Color shadow = Color(0xFFDDA2B0);
}

class Sizes {
  static double extraSmall = 10;
  static double small = 13;
  static double medium = 18;
  static double large = 24;
  static double extraLarge = 32;
  static double padding = 15;
}

class AppBorderRadius {
  static double borderR = 15;
  static double borderHeavy = 50;
}

class AppShadows {
  static final List<BoxShadow> primaryShadow = [
    BoxShadow(
      color: AppColors.shadow.withAlpha(75),
      blurRadius: 10,
      spreadRadius: 1,
      offset: const Offset(0, 2),
    ),
  ];
}

ThemeData buildAppTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.background,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimary,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Inter_18pt',
        fontWeight: FontWeight.w600,
        fontSize: Sizes.large,
        color: Colors.black87,
      ),
      iconTheme: IconThemeData(color: Colors.black87, size: 28),
      actionsIconTheme: IconThemeData(color: Colors.white),
    ),

    // Texts
    textTheme: TextTheme(
      // Onboarding
      displayLarge: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.extraLarge,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 1,
      ),

      // Sections Titles
      titleMedium: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.large,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),

      // Sub-Sections Titles
      titleSmall: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.small * 1.2,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),

      // Cards Title
      bodyLarge: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.medium,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),

      // Cards sub-title
      bodyMedium: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.medium,
        fontWeight: FontWeight.w500,
        color: Colors.black45,
      ),

      // Cards Descriptions
      bodySmall: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.small,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),

      // Username
      labelLarge: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.medium + 1.1,
        fontWeight: FontWeight.bold,
        color: Colors.red[400],
        letterSpacing: 0.2,
      ),

      // Buttons Texts
      labelMedium: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.medium,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),

      // Sub-Buttons Texts
      labelSmall: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.small,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white10,
        textStyle: TextStyle(
          fontFamily: 'Inter_18pt',
          fontWeight: FontWeight.w500,
          fontSize: Sizes.medium,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderHeavy),
        ),
        elevation: 2.5,
        shadowColor: Colors.black87,
        minimumSize: const Size(double.infinity, 48),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        backgroundColor: Colors.white.withAlpha(25),
        side: BorderSide(color: AppColors.borders.withAlpha(100), width: 1),
        textStyle: TextStyle(
          fontFamily: 'Inter_18pt',
          fontWeight: FontWeight.w700,
          fontSize: Sizes.large,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderHeavy),
        ),
        minimumSize: const Size(double.infinity, 48),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      labelStyle: TextStyle(
        fontFamily: 'Inter_18pt',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.white,
      ),

      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1.5),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppBorderRadius.borderR),
        ),
        borderSide: BorderSide(color: Colors.white, width: 1.5),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
      ),
      shadowColor: AppColors.shadow,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
  );
}
