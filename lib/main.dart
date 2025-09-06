import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/features/screens/services/change_password.dart';
import 'package:beuty_support/features/screens/services/delete_account.dart';
import 'package:beuty_support/features/screens/services/update_username.dart';
import 'package:beuty_support/features/screens/home/favorite_tab.dart';
import 'package:beuty_support/features/screens/home/offers_tab.dart';
import 'package:beuty_support/features/screens/home/profile_tab.dart';
import 'package:beuty_support/features/providers/language_provider.dart';
import 'package:beuty_support/features/providers/user_provider.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:beuty_support/layout/auth_layout.dart';
import 'package:beuty_support/features/screens/services/add_center_screen.dart';
import 'package:beuty_support/features/screens/admin/admin_dashboard_screen.dart';
import 'package:beuty_support/features/screens/services/reset_password.dart';
import 'package:beuty_support/features/screens/auth/sign_in_screen.dart';
import 'package:beuty_support/features/screens/auth/sign_up_screen.dart';
import 'package:beuty_support/features/screens/onboarding/onboarding_screen.dart';
import 'package:beuty_support/features/screens/home/center_details.dart';
import 'package:beuty_support/features/screens/services/write_a_review.dart';
import 'package:beuty_support/layout/tabs_layout.dart';
import 'package:beuty_support/features/screens/home/home_tab.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('languageCode');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(Locale(languageCode ?? "en")),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
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
    return MaterialApp(
      title: "Beauty Support",
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
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

        // First Screen
        "/onboardingscreen": (context) => const OnboardingScreen(),

        // Auth screens
        "/login": (context) => const SignInScreen(),
        "/signup": (context) => const SignUpScreen(),

        // Tabs
        "/tabs": (context) => const TabsLayout(),
        "/hometab": (context) => const HomeTab(),
        "/offerstab": (context) => const OffersTab(),
        "/favoritestab": (context) => const FavoriteTab(),
        "/profiletab": (context) => const ProfileTab(),

        // Sub-Screens
        "/admindashboardscreen": (context) => const AdminDashboardScreen(),
        "/centerdetails": (context) => const CenterDetails(),
        "/writeareview": (context) => const WriteAReview(),
        "/resetpassword": (context) => const ResetPassword(),
        "/changepassword": (context) => const ChangePassword(),
        "/updateusername": (context) => const UpdateUsername(),
        "/deleteaccount": (context) => const DeleteAccount(),
        "/addcenterscreen": (context) => const AddCenterScreen(),
      },
    );
  }
}
