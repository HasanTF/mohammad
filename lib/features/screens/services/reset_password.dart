import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _controllerEmail = TextEditingController();
  String errorMessage = "";
  bool isLoading = false;

  @override
  void dispose() {
    _controllerEmail.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    final email = _controllerEmail.text.trim();

    if (email.isEmpty) {
      setState(() {
        errorMessage = "Email field is required.";
        isLoading = false;
      });
      return;
    }

    try {
      await authServices.value.resetPassword(
        email: _controllerEmail.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Check your email for reset instructions."),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessage =
            error.message ?? "An error occurred while resetting the password.";
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "An unexpected error occurred.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, semanticLabel: "Go back"),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_outline,
                  size: screenWidth * 0.2,
                  color: AppColors.primary,
                  semanticLabel: "Lock icon",
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  "Forgot Password?",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Enter your email to receive\nreset instructions",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.45,
            padding: EdgeInsets.all(screenWidth * 0.06),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, -2),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomInputField(
                  label: "Email",
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                if (errorMessage.isNotEmpty) ...[
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    errorMessage,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.redAccent),
                    textAlign: TextAlign.center,
                    semanticsLabel: "Error message",
                  ),
                ],
                SizedBox(height: screenHeight * 0.03),
                isLoading
                    ? const CircularProgressIndicator(
                        semanticsLabel: "Loading",
                        color: AppColors.secondaryDark,
                      )
                    : MyButton(
                        onPressed: resetPassword,
                        text: "Reset Password",
                        backgroundColor: AppColors.secondaryDark,
                        textColor: AppColors.textPrimary,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
