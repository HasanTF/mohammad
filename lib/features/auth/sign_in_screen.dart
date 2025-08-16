import 'package:beuty_support/core/constants/colors.dart';
import 'package:beuty_support/core/constants/sizes.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:beuty_support/layout/auth_layout.dart';
import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/core/widget/custom_button.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopClipPath(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontal),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.70,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const WelcomingText(),
                    InputFields(
                      emailController: emailController,
                      passwordController: passwordController,
                      errorMessage: errorMessage,
                    ),
                    Column(
                      children: [
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.cPrimary,
                                ),
                              )
                            : CustomButton(
                                text: S.of(context).login,
                                onPressed: login,
                              ),
                        const SizedBox(height: 18.0),
                        SignupText(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputFields extends StatelessWidget {
  const InputFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.errorMessage,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          errorMessage,
          style: TextStyle(color: Colors.redAccent, fontSize: Sizes.small),
        ),
        const RememberMe(),
      ],
    );
  }
}

class SignupText extends StatelessWidget {
  const SignupText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: S.of(context).dontHaveAccount,
        style: TextStyle(
          color: AppColors.cLightGrey,
          fontSize: Sizes.extraSmall,
        ),
        children: [
          TextSpan(
            text: S.of(context).register,
            style: TextStyle(
              color: AppColors.cPrimary,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),

            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, '/signup');
              },
          ),
        ],
      ),
    );
  }
}

class RememberMe extends StatelessWidget {
  const RememberMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.check_box, color: AppColors.cPrimary),
            const SizedBox(width: 8),
            Text(
              S.of(context).rememberMe,
              style: TextStyle(
                color: AppColors.cLightGrey,
                fontSize: Sizes.extraSmall,
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/resetpassword");
          },
          child: Text(
            S.of(context).forgotPassword,
            style: TextStyle(
              color: AppColors.cLightGrey,
              fontSize: Sizes.extraSmall,
            ),
          ),
        ),
      ],
    );
  }
}

class WelcomingText extends StatelessWidget {
  const WelcomingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context).welcomeBack,
          style: TextStyle(
            color: AppColors.cPrimary,
            fontSize: Sizes.large,
            fontWeight: FontWeight.bold,
            fontFamily: "Dalius",
          ),
        ),
        Text(
          S.of(context).loginText,
          style: TextStyle(
            color: AppColors.cLightGrey,
            fontSize: Sizes.small,
            fontFamily: "Dalius",
          ),
        ),
      ],
    );
  }
}

class TopClipPath extends StatelessWidget {
  const TopClipPath({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopWaveClipper(),
      child: Container(
        width: double.infinity,
        height: 0.25.sh,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/onboarding.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height * 0.85,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.70,
      size.width,
      size.height * 0.80,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
