import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:beuty_support/features/providers/user_provider.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  GoogleSignInAccount? _user;

  bool isLoading = false;
  bool isGoogleLoading = false;
  bool isAppleLoading = false;
  String errorMessage = "";

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmailOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).pleaseEnterEmail;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value) &&
        !RegExp(r'^\+?[1-9]\d{9,14}$').hasMatch(value)) {
      return S.of(context).invalidEmailAddress;
    }
    return null;
  }

  // Validate password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).pleaseEnterPassword;
    }
    if (value.length < 6) {
      return S.of(context).passwordTooShort;
    }
    return null;
  }

  // Handle login process with error handling
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    try {
      await authServices.value.signIn(
        email: _emailOrPhoneController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/",
          (Route<dynamic> route) => false,
        );
      }
    } catch (error) {
      String errorMsg;
      switch (error.toString()) {
        case '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.':
          // ignore: use_build_context_synchronously
          errorMsg = S.of(context).noAccountFound;
          break;
        case '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.':
          // ignore: use_build_context_synchronously
          errorMsg = S.of(context).incorrectPassword;
          break;
        case '[firebase_auth/invalid-email] The email address is badly formatted.':
          // ignore: use_build_context_synchronously
          errorMsg = S.of(context).invalidEmailOrPhoneFormat;
          break;
        case '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.':
          // ignore: use_build_context_synchronously
          errorMsg = S.of(context).tooManyRequests;
          break;
        case '[firebase_auth/user-disabled] The user account has been disabled by an administrator.':
          // ignore: use_build_context_synchronously
          errorMsg = S.of(context).accountDisabled;
          break;
        default:
          errorMsg = S.of(context).genericError;
          debugPrint('Login error: $error');
      }
      if (mounted) {
        setState(() {
          errorMessage = errorMsg;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      isGoogleLoading = true;
    });

    try {
      final userCredential = await authServices.value.signInWithGoogle();
      if (userCredential != null && mounted) {
        // تحديث UserProvider
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setDisplayName(userCredential.user?.displayName ?? "User");
        userProvider.setPhotoURL(userCredential.user?.photoURL ?? "");

        // التنقل إلى TabsLayout
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/",
          (Route<dynamic> route) => false,
        );
      } else {
        setState(() {
          errorMessage = S.of(context).error;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).error),
              backgroundColor: AppColors.error,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        errorMessage = S.of(context).genericError;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Google Signin failed. Please try again."),
            backgroundColor: AppColors.error,
            duration: const Duration(milliseconds: 1500),
          ),
        );
      }
    } finally {
      setState(() {
        isGoogleLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png", // Replace with your logo asset
                    fit: BoxFit.contain,
                    height: screenHeight * 0.20,
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomInputField(
                          label: S.of(context).emailLabel,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.green,
                          ),
                          controller: _emailOrPhoneController,
                          validator: _validateEmailOrPhone,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        CustomInputField(
                          label: S.of(context).passwordLabel,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.green,
                          ),
                          controller: _passwordController,
                          obscureText: true,
                          validator: _validatePassword,
                          autofillHints: const [AutofillHints.password],
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/resetpassword");
                          },
                          child: Text(
                            S.of(context).forgotPassword,
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                        if (errorMessage.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.01),
                            child: Text(
                              errorMessage,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AppColors.error),
                            ),
                          ),
                        SizedBox(height: screenHeight * 0.03),
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : MyButton(
                                onPressed: _login,
                                text: S.of(context).loginButton,
                                backgroundColor: const Color(
                                  0xFFFFD700,
                                ), // Yellow
                                textColor: Colors.grey[700],
                              ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          S.of(context).orText,
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(color: AppColors.textPrimary),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        MyButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    S.of(context).appleSignInDisabledTitle,
                                  ),
                                  content: Text(
                                    S.of(context).appleSignInDisabledMessage,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(S.of(context).okButton),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          text: S.of(context).loginWithApple,
                          backgroundColor: AppColors.secondaryLight,
                          textColor: AppColors.textPrimary,
                          icon: Icons.apple,
                        ),

                        SizedBox(height: screenHeight * 0.015),
                        isGoogleLoading
                            ? const Center(child: CircularProgressIndicator())
                            : MyButton(
                                onPressed: _loginWithGoogle,
                                text: S.of(context).loginWithGoogle,
                                backgroundColor: AppColors.textPrimary,
                                textColor: AppColors.background,
                                icon: Icons.g_mobiledata,
                              ),

                        SizedBox(height: screenHeight * 0.02),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).dontHaveAccount,
                              style: Theme.of(
                                context,
                              ).textTheme.labelSmall!.copyWith(fontSize: 14),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/signup");
                              },
                              child: Text(
                                S.of(context).signupText,
                                style: Theme.of(context).textTheme.labelSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
