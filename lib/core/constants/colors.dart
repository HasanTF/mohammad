import 'package:flutter/material.dart';

class AppColors {
  static const Color cWhite = Color(0xFFF5F8FC);
  static const Color cSecondary = Color(0xFFedddde);
  static const Color cPrimary = Color(0xFFcd754e);
  static const Color cLightGrey = Color(0xFF777777);
}

class AppShadows {
  static List<BoxShadow> get primaryShadow => [
    BoxShadow(
      color: AppColors.cPrimary.withAlpha(100),
      blurRadius: 10,
      offset: Offset(1, 1),
    ),
    BoxShadow(
      color: AppColors.cSecondary.withAlpha(100),
      blurRadius: 5,
      offset: Offset(-1, 0.5),
    ),
  ];
}
