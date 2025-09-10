import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFFD33C);
  static const Color secondaryLight = Color(0xFFA5C5B1);
  static const Color secondaryDark = Color(0xFFA5C5B1);
  static const Color textPrimary = Color(0xFF3E3E3E);
  static const Color textSecondary = Color(0xFF598DD4);
  static const Color background = Color(0xFFFAF8F3);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFFF5252);
}

class Sizes {
  static double extraSmall = 16;
  static double small = 18;
  static double medium = 26;
  static double large = 34;
  static double extraLarge = 28;
  static double padding = 15;
}

class AppBorderRadius {
  static double borderR = 25;
  static double borderHeavy = 50;
}

class AppShadows {
  static final List<BoxShadow> primaryShadow = [
    BoxShadow(blurRadius: 10, spreadRadius: 1, offset: const Offset(0, 2)),
  ];
}

ThemeData buildAppTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    primaryColor: AppColors.secondaryDark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.secondaryDark,
      secondary: AppColors.secondaryLight,
      surface: AppColors.background,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimary,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.secondaryLight,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Inter_18pt',
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: Colors.black87,
      ),
      iconTheme: IconThemeData(color: Colors.black87, size: 28),
      actionsIconTheme: IconThemeData(color: Colors.white),
    ),

    // Texts
    textTheme: TextTheme(
      // --------------DONE-------------- //
      // Headers
      displayLarge: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.extraLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        letterSpacing: 1,
      ),

      // Sub-Headers
      displayMedium: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.small,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),

      displaySmall: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.extraSmall,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryLight,
      ),
      // --------------DONE-------------- //

      // Sections Titles
      titleMedium: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.medium,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
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
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
      ),

      // Cards sub-title
      bodyMedium: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryDark,
      ),

      // Cards Descriptions
      bodySmall: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
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
        fontSize: Sizes.small,
        fontWeight: FontWeight.bold,
        color: AppColors.background,
      ),

      // Sub-Buttons Texts
      labelSmall: TextStyle(
        fontFamily: 'Inter_18pt',
        fontSize: Sizes.small,
        fontWeight: FontWeight.w300,
        color: AppColors.textPrimary,
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
  );
}
