import 'package:beuty_support/core/constants/colors.dart';
import 'package:beuty_support/core/constants/sizes.dart';
import 'package:beuty_support/core/widget/language_switcher.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          const BackgroundBlackLayer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.horizontal,
              vertical: AppPadding.vertical * 2,
            ),
            child: Column(
              children: [
                LanguageSwitcher(),
                WelcomingText(),
                Spacer(),
                SignInButton(),
                CreateAccountText(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreateAccountText extends StatelessWidget {
  const CreateAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/signup');
      },
      child: Text(
        S.of(context).createAccount,
        style: TextStyle(color: Colors.white70, fontSize: Sizes.small),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },

        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          overlayColor: Colors.transparent,
        ),
        child: Text(
          S.of(context).login,
          style: TextStyle(
            color: Colors.white,
            fontSize: Sizes.medium,
            fontWeight: FontWeight.bold,
            fontFamily: "Delius",
          ),
        ),
      ),
    );
  }
}

class WelcomingText extends StatelessWidget {
  const WelcomingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        S.of(context).onboardingWelcomeText,
        style: TextStyle(
          color: AppColors.cPrimary,
          fontWeight: FontWeight.bold,
          fontSize: Sizes.large,
          fontFamily: "Delius",
          letterSpacing: 2,
        ),
      ),
    );
  }
}

class BackgroundBlackLayer extends StatelessWidget {
  const BackgroundBlackLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(color: Colors.black.withAlpha(200)),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset('assets/images/onboarding.jpg', fit: BoxFit.cover),
    );
  }
}
