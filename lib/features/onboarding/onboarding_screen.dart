import 'dart:ui';

import 'package:beuty_support/core/constants/themes.dart';
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
          // Background image & Black layer
          Background(),

          // Content
          Padding(
            padding: EdgeInsets.all(Sizes.padding),
            child: SafeArea(
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
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppBorderRadius.borderHeavy),
      child: OutlinedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/login");
        },
        child: Text(
          S.of(context).login,
          style: Theme.of(context).textTheme.labelMedium,
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
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Text(
        S.of(context).onboardingWelcomeText,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Image.asset(
              "assets/images/mybadlife.jpeg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(color: Colors.black54),
      ],
    );
  }
}
