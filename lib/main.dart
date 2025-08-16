import 'package:beuty_support/features/auth/user_services/change_password.dart';
import 'package:beuty_support/features/auth/user_services/delete_account.dart';
import 'package:beuty_support/features/auth/user_services/update_username.dart';
import 'package:beuty_support/features/providers/language_provider.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:beuty_support/layout/auth_layout.dart';
import 'package:beuty_support/features/home/add_center_screen.dart';
import 'package:beuty_support/features/admin/admin_dashboard_screen.dart';
import 'package:beuty_support/features/auth/reset_password.dart';
import 'package:beuty_support/features/auth/sign_in_screen.dart';
import 'package:beuty_support/features/auth/sign_up_screen.dart';
import 'package:beuty_support/features/onboarding/onboarding_screen.dart';
import 'package:beuty_support/features/home/center_details.dart';
import 'package:beuty_support/features/home/write_a_review.dart';
import 'package:beuty_support/features/home/tabs_layout.dart';
import 'package:beuty_support/features/home/tabs/home_tab.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('languageCode');

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint("✅ Firebase initialized successfully");
  } catch (e) {
    debugPrint("❌ Firebase initialization failed: $e");
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(Locale(languageCode ?? "en")),
      child: DevicePreview(
        enabled: true,
        tools: const [...DevicePreview.defaultTools],
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: "Beauty Support",
          debugShowCheckedModeBanner: false,
          restorationScopeId: "app",
          locale: Provider.of<LanguageProvider>(context).locale,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          builder: DevicePreview.appBuilder,
          initialRoute: "/",
          routes: {
            "/": (context) => const AuthLayout(),
            "/onboardingscreen": (context) => const OnboardingScreen(),
            "/login": (context) => const SignInScreen(),
            "/signup": (context) => const SignUpScreen(),
            "/hometab": (context) => const HomeTab(),
            "/tabs": (context) => const Tabs(),
            "/centerdetails": (context) => const CenterDetails(),
            "/writeareview": (context) => const WriteAReview(),
            "/resetpassword": (context) => const ResetPassword(),
            "/changepassword": (context) => const ChangePassword(),
            "/updateusername": (context) => const UpdateUsername(),
            "/deleteaccount": (context) => const DeleteAccount(),
            "/admindashboardscreen": (context) => const AdminDashboardScreen(),
            "/addcenterscreen": (context) => const AddCenterScreen(),
          },
        );
      },
    );
  }
}
