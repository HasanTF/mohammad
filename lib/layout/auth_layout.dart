import 'package:beuty_support/features/screens/onboarding/onboarding_screen.dart';
import 'package:beuty_support/layout/tabs_layout.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageInNotConnected});

  final Widget? pageInNotConnected;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // 1️⃣ استخدمنا stream مباشر من FirebaseAuth لتتبع حالة تسجيل الدخول
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 2️⃣ نعرض دائرة تحميل أثناء الانتظار
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          // 3️⃣ المستخدم موجود -> تحويل مباشر إلى TabsLayout
          // ✅ هذا يضمن التنقل فور تسجيل الدخول
          return const TabsLayout();
        } else {
          // 4️⃣ لم يسجل دخول -> نعرض Onboarding أو الصفحة المرسلة
          return pageInNotConnected ?? const OnboardingScreen();
        }
      },
    );
  }
}
