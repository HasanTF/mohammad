import 'dart:ui';
import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:beuty_support/layout/auth_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessage = "";
  bool isLoading = false;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    final user =
        authServices.value.currentUser; // جلب اليوزر الحالي من Firebase
    if (user != null) {
      // ✅ إذا المستخدم لسا مسجل دخول → فوت عالتطبيق مباشرة
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthLayout()),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Login with email and password function
  void login() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    try {
      await authServices.value.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthLayout()),
      );
    } on FirebaseException catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.message ?? "This is not working!";
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
          const Background(),

          // Main padding
          Padding(
            padding: EdgeInsets.all(Sizes.padding * 2),

            // Content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),

                // Login Text
                const LoginText(),

                const SizedBox(height: 50),

                // E-Mail & Password Inputfeilds
                InputFields(
                  emailController: emailController,
                  passwordController: passwordController,
                  errorMessage: errorMessage,
                  rememberMe: rememberMe,
                  onRememberMeChanged: (value) {
                    setState(() {
                      rememberMe = value;
                    });
                  },
                ),

                const SizedBox(height: 35),

                // Login Button
                isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : MyButton(
                        onPressed: login,
                        text: "Login",
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                      ),

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

                const Spacer(),

                // Sign Up Text
                const DontHaveAccount(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Don't have an account?",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/signup");
          },
          child: Text(
            "SignUp",
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

class InputFields extends StatelessWidget {
  const InputFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.errorMessage,
    required this.rememberMe,
    required this.onRememberMeChanged,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String errorMessage;
  final bool rememberMe;
  final ValueChanged<bool> onRememberMeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInputField(
          controller: emailController,
          label: "E-Mail",
          obscureText: false,
          prefixIcon: const Icon(Icons.email),
        ),
        CustomInputField(
          controller: passwordController,
          label: "Password",
          obscureText: true,
          prefixIcon: const Icon(Icons.lock),
        ),
        Text(
          errorMessage,
          style: TextStyle(color: Colors.redAccent, fontSize: Sizes.small),
        ),
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: (value) => onRememberMeChanged(value ?? false),
              side: const BorderSide(color: Colors.white, width: 2),
            ),
            const SizedBox(width: 5),
            Text("Remember Me", style: Theme.of(context).textTheme.labelSmall),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/resetpassword');
              },
              child: Text(
                "Forgot your password?",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Log into\nyour account",
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
