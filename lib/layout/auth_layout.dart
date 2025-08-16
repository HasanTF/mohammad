import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/features/onboarding/onboarding_screen.dart';
import 'package:beuty_support/features/home/tabs_layout.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageInNotConnected});

  final Widget? pageInNotConnected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authServices,
      builder: (context, authSevices, child) {
        return StreamBuilder(
          stream: authSevices.authStateChanges,
          builder: (context, snapshot) {
            Widget widget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              widget = Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              widget = const Tabs();
            } else {
              widget = pageInNotConnected ?? const OnboardingScreen();
            }
            return widget;
          },
        );
      },
    );
  }
}
