import 'dart:ui';

import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/core/widget/confirmation_dialog.dart';
import 'package:beuty_support/core/widget/language_switcher.dart';
import 'package:beuty_support/core/widget/profile_services.dart';
import 'package:beuty_support/features/auth/user_services/change_password.dart';
import 'package:beuty_support/features/auth/user_services/delete_account.dart';
import 'package:beuty_support/features/auth/user_services/update_username.dart';
import 'package:beuty_support/features/providers/user_provider.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final kHeight = screenSize.height;

    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? "Error loading E-Mail";

    void logout() async {
      try {
        await authServices.value.signOut();
      } on FirebaseAuthException catch (error) {
        debugPrint(error.message);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Sizes.padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // My Profile
                  HeaderText(),

                  SizedBox(height: 10),

                  // User Details Box
                  UserDetails(kHeight: kHeight, email: email),

                  SizedBox(height: 10),

                  // Settings & Services
                  Services(kHeight: kHeight),

                  OutlinedButton(
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => ConfirmationDialog(
                          title: "Confirm Logout",
                          content: "Are you sure you want to logout?",
                          confirmText: "Logout",
                          cancelText: "Cancel",
                          confirmColor: Colors.red,
                          cancelColor: Colors.black,
                        ),
                      );

                      if (confirm == true) {
                        logout();
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(
                        color: Colors.red.withAlpha(100),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      S.of(context).logout,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).myProfile,
      textAlign: TextAlign.center,
      style: Theme.of(
        context,
      ).textTheme.displayLarge!.copyWith(color: Colors.black87),
    );
  }
}

class Services extends StatelessWidget {
  const Services({super.key, required this.kHeight});

  final double kHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.of(context).settings,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 10),
        ProfileServices(
          text: S.of(context).updateUsername,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UpdateUsername()),
            );
          },
        ),
        ProfileServices(
          text: S.of(context).changePassword,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChangePassword()),
            );
          },
        ),
        ProfileServices(
          text: S.of(context).deleteAccount,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DeleteAccount()),
            );
          },
        ),
        ProfileServices(
          text: S.of(context).aboutApp,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UpdateUsername()),
            );
          },
        ),
      ],
    );
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
    required this.kHeight,
    required this.email, // نحتفظ بالإيميل كما هو
  });

  final double kHeight;
  final String email;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final displayName = userProvider.displayName;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ), // زيادة الخشونة للغباشية
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white38, // شفافية أفتح وأجمل
            borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
            border: Border.all(color: Colors.white70, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 18.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LanguageSwitcher(),
                const SizedBox(height: 12),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/avatar.jpg"),
                  backgroundColor: AppColors.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  displayName,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  email,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
