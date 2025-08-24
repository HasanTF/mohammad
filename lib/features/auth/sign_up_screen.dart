import 'dart:ui';

import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:beuty_support/layout/auth_layout.dart';
import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = "";

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Register with E-mail & Password + Username
  void register() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    try {
      UserCredential userCredential = await authServices.value.createAccount(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        username: nameController.text.trim(),
      );

      await userCredential.user?.updateDisplayName(nameController.text.trim());
      await userCredential.user?.reload();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthLayout()),
      );
    } on FirebaseAuthException catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.message ?? "An unknown error occurred.";
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image & Black layer
          Background(),

          // Main padding
          Padding(
            padding: EdgeInsets.all(Sizes.padding * 2),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                // Register Text
                RegisterText(),

                SizedBox(height: 25),

                // E-Mail & Password + Username Inputfeilds
                InputFields(
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  errorMessege: errorMessage,
                ),

                SizedBox(height: 35),

                // Signuo Button
                MyButton(
                  onPressed: register,
                  text: "Signup",
                  backgroundColor: Colors.black87,
                ),

                Spacer(),

                // Devider
                TextDivider(),

                Spacer(),

                // Login Facebook
                MyButton(
                  onPressed: () {},
                  text: "Login with Facebook",
                  icon: Icons.facebook,
                  backgroundColor: Colors.white,
                  textColor: Colors.black87,
                ),

                // Login Apple
                MyButton(
                  onPressed: () {},
                  text: "Login with Apple",
                  icon: Icons.apple,
                  backgroundColor: AppColors.primary,
                  textColor: Colors.black,
                ),

                Spacer(),

                AlreadyHaveAccount(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Already have an account?",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/login");
          },
          child: Text(
            "Login",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.black54,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class TextDivider extends StatelessWidget {
  const TextDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.white, thickness: 1.5)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Text(
            S.of(context).orContinueWith,
            style: TextStyle(color: Colors.white, fontSize: Sizes.small),
          ),
        ),
        const Expanded(child: Divider(color: Colors.white, thickness: 1.5)),
      ],
    );
  }
}

class InputFields extends StatelessWidget {
  const InputFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.errorMessege,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String errorMessege;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInputField(
          controller: nameController,
          label: S.of(context).fullName,
          obscureText: false,
          prefixIcon: const Icon(Icons.person),
        ),
        CustomInputField(
          controller: emailController,
          label: S.of(context).email,
          obscureText: false,
          prefixIcon: const Icon(Icons.email),
        ),
        CustomInputField(
          controller: passwordController,
          label: S.of(context).password,
          obscureText: true,
          prefixIcon: const Icon(Icons.lock),
        ),
        Text(
          errorMessege,
          style: TextStyle(color: Colors.redAccent, fontSize: Sizes.small),
        ),
        Row(
          children: [
            Icon(Icons.check_box, color: Colors.white),
            const SizedBox(width: 5),
            Text("Remember Me", style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ],
    );
  }
}

class RegisterText extends StatelessWidget {
  const RegisterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Create your\nnew account",
      style: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
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
        SizedBox(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Image.asset(
              "assets/images/mybadlife.jpeg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(color: Colors.black12),
      ],
    );
  }
}
