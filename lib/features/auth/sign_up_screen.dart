import 'package:beuty_support/core/constants/colors.dart';
import 'package:beuty_support/core/constants/sizes.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:beuty_support/layout/auth_layout.dart';
import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/core/widget/custom_button.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.horizontal,
                    vertical: AppPadding.vertical * 2,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HeaderText(),
                      InputFields(
                        nameController: nameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        errorMessege: errorMessage,
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
                                  text: S.of(context).register,
                                  onPressed: register,
                                ),
                          const SizedBox(height: 10.0),
                          RememberMe(onTap: () {}),
                        ],
                      ),
                      SizedBox(height: 25.h),
                      TextDivider(),
                      SocialButtons(),
                      SignUpText(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
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
      ],
    );
  }
}

class RememberMe extends StatelessWidget {
  final VoidCallback onTap;
  const RememberMe({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: onTap,
              child: Icon(
                Icons.check_box,
                color: AppColors.cPrimary,
                size: Sizes.medium,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              S.of(context).rememberMe,
              style: TextStyle(
                color: AppColors.cLightGrey,
                fontSize: Sizes.small,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          S.of(context).register,
          style: TextStyle(
            color: AppColors.cPrimary,
            fontSize: Sizes.large,
            fontWeight: FontWeight.bold,
            fontFamily: "Dalius",
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          S.of(context).createNewAccount,
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

class TextDivider extends StatelessWidget {
  const TextDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.black26, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Text(
            S.of(context).orContinueWith,
            style: TextStyle(color: Colors.black, fontSize: Sizes.small),
          ),
        ),
        const Expanded(child: Divider(color: Colors.black26, thickness: 1)),
      ],
    );
  }
}

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.all(Sizes.small),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(Icons.facebook, size: Sizes.medium),
        ),
        Container(
          padding: EdgeInsets.all(Sizes.small),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(Icons.g_mobiledata, size: Sizes.medium),
        ),
        Container(
          padding: EdgeInsets.all(Sizes.small),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(Icons.apple, size: Sizes.medium),
        ),
      ],
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: S.of(context).alreadyHaveAccount,
          style: TextStyle(
            color: AppColors.cLightGrey,
            fontSize: Sizes.extraSmall,
          ),
          children: [
            TextSpan(
              text: S.of(context).login,
              style: TextStyle(
                color: AppColors.cPrimary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/login');
                },
            ),
          ],
        ),
      ),
    );
  }
}
