import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String errorMessage = "";
  bool agree = false;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Handle registration process with Firebase authentication
  Future<void> _register() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    if (!_formKey.currentState!.validate() || !agree) {
      setState(() {
        errorMessage = !agree
            ? 'Please agree to the Terms & Privacy'
            : errorMessage;
        isLoading = false;
      });
      return;
    }

    try {
      // تخزين الـ context قبل العملية الغير متزامنة

      await authServices.value.createAccount(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        name: _usernameController.text,
      );

      if (mounted) Navigator.pushNamed(context, "/");
    } on FirebaseAuthException catch (e) {
      String errorMsg;
      switch (e.code) {
        case 'email-already-in-use':
          errorMsg = 'This email is already registered';
          break;
        case 'invalid-email':
          errorMsg = 'Invalid email format';
          break;
        case 'weak-password':
          errorMsg = 'Password is too weak';
          break;
        case 'too-many-requests':
          errorMsg = 'Too many attempts. Please try again later';
          break;
        default:
          errorMsg = 'An error occurred. Please try again';
          debugPrint('Registration error: $e');
      }
      setState(() {
        errorMessage = errorMsg;
        isLoading = false;
      });
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Header(),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.10),
                child: Column(
                  children: [
                    InputFeilds(
                      formKey: _formKey,
                      usernameController: _usernameController,
                      screenHeight: screenHeight,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                    ),
                    TermsAndPrivacy(
                      agree: agree,
                      onChanged: (value) =>
                          setState(() => agree = value ?? false),
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
                    SizedBox(height: screenHeight * 0.05),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : MyButton(
                            onPressed: _register,
                            text: "Sign Up",
                            backgroundColor: const Color(0xFFFFD700), // Yellow
                            textColor: Colors.grey[700],
                          ),
                    SizedBox(height: screenHeight * 0.02),
                    const FooterText(),
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

class FooterText extends StatelessWidget {
  const FooterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Have an account? ",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/login");
          },
          child: Text(
            "Login",
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }
}

class TermsAndPrivacy extends StatelessWidget {
  final bool agree;
  final ValueChanged<bool?> onChanged;

  const TermsAndPrivacy({
    super.key,
    required this.agree,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: agree, onChanged: onChanged),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: "I agree to the ",
              style: Theme.of(context).textTheme.labelSmall,
              children: [
                TextSpan(
                  text: "Terms & Privacy",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InputFeilds extends StatefulWidget {
  const InputFeilds({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.screenHeight,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final double screenHeight;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<InputFeilds> createState() => _InputFeildsState();
}

class _InputFeildsState extends State<InputFeilds> {
  /// Validate email format
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validate username
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  /// Validate password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Validate confirm password
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != widget.passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomInputField(
            label: "Username",
            prefixIcon: const Icon(Icons.person, color: Colors.green),
            controller: widget.usernameController,
            validator: _validateUsername,
            obscureText: false,
            autofillHints: const [AutofillHints.username],
          ),
          SizedBox(height: widget.screenHeight * 0.02),
          CustomInputField(
            label: "E-mail",
            prefixIcon: const Icon(Icons.mail, color: Colors.green),
            controller: widget.emailController,
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
          ),
          SizedBox(height: widget.screenHeight * 0.02),
          CustomInputField(
            label: "Password",
            prefixIcon: const Icon(Icons.lock, color: Colors.green),
            controller: widget.passwordController,
            validator: _validatePassword,
            obscureText: true,
            autofillHints: const [AutofillHints.newPassword],
          ),
          SizedBox(height: widget.screenHeight * 0.02),
          CustomInputField(
            label: "Confirm Password",
            prefixIcon: const Icon(Icons.lock, color: Colors.green),
            controller: widget.confirmPasswordController,
            validator: _validateConfirmPassword,
            obscureText: true,
            autofillHints: const [AutofillHints.newPassword],
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.40,
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 3),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Row(
              children: [
                Image.asset(
                  "assets/images/logo2.png",
                  fit: BoxFit.contain,
                  width: 60,
                ),
                const SizedBox(width: 8),
                Text(
                  "CLINICLY",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Let’s\nCreate Your\nAccount",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
