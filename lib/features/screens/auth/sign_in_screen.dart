import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String errorMessage = "";

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmailOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email or phone';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value) &&
        !RegExp(r'^\+?[1-9]\d{9,14}$').hasMatch(value)) {
      return 'Please enter a valid email or phone number';
    }
    return null;
  }

  // Validate password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
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
          errorMsg = 'No account found with this email or phone';
          break;
        case '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.':
          errorMsg = 'Incorrect password';
          break;
        case '[firebase_auth/invalid-email] The email address is badly formatted.':
          errorMsg = 'Invalid email or phone format';
          break;
        case '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.':
          errorMsg = 'Too many attempts. Please try again later';
          break;
        case '[firebase_auth/user-disabled] The user account has been disabled by an administrator.':
          errorMsg = 'This account has been disabled';
          break;
        default:
          errorMsg = 'An error occurred. Please try again';
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
                          label: "Email",
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
                          label: "Password",
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
                            "Forgot Password?",
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
                                text: "Login",
                                backgroundColor: const Color(
                                  0xFFFFD700,
                                ), // Yellow
                                textColor: Colors.grey[700],
                              ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "Or",
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(color: AppColors.textPrimary),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        MyButton(
                          onPressed: () {},
                          text: "Login with Apple",
                          backgroundColor: AppColors.secondaryLight,
                          textColor: AppColors.textPrimary,
                          icon: Icons.apple,
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        MyButton(
                          onPressed: () {},
                          text: "Login with Google",
                          backgroundColor: AppColors.textPrimary,
                          textColor: Colors.white,
                          icon: Icons.g_mobiledata,
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Dont have an account? ",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/signup");
                              },
                              child: Text(
                                "Signup",
                                style: Theme.of(context).textTheme.labelSmall!
                                    .copyWith(fontWeight: FontWeight.w900),
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
