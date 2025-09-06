import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String errorMessage = "";
  bool isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> updatePassword() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    final currentPassword = _currentPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        errorMessage = "AllFieldsRequired";
        isLoading = false;
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        errorMessage = "PasswordsDontMatch";
        isLoading = false;
      });
      return;
    }

    if (newPassword.length < 6) {
      setState(() {
        errorMessage = "Password is too short";
        isLoading = false;
      });
      return;
    }

    try {
      final email = FirebaseAuth.instance.currentUser?.email;

      if (email == null) {
        setState(() {
          errorMessage = "You need to reLogin";
          isLoading = false;
        });
        return;
      }

      await authServices.value.resetPasswordFromCurrentPassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        email: email,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("S.of(context).passwordUpdatedSuccessfully"),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessage = error.message ?? "S.of(context).errorOccurred";
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "S.of(context).unexpectedError";
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
          icon: const Icon(Icons.arrow_back, semanticLabel: "رجوع"),
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
                  semanticLabel: "أيقونة القفل",
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  S.of(context).changePassword,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.secondaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "enterNewPassword",
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.55,
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
                  label: S.of(context).email,
                  controller: _emailController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomInputField(
                  label: S.of(context).currentPassword,
                  controller: _currentPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomInputField(
                  label: S.of(context).newPassword,
                  controller: _newPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomInputField(
                  label: S.of(context).confirmPassword,
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                if (errorMessage.isNotEmpty) ...[
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    errorMessage,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.redAccent),
                    textAlign: TextAlign.center,
                    semanticsLabel: "رسالة خطأ",
                  ),
                ],
                SizedBox(height: screenHeight * 0.03),
                isLoading
                    ? const CircularProgressIndicator(
                        semanticsLabel: "جارٍ التحميل",
                        color: AppColors.secondaryDark,
                      )
                    : MyButton(
                        onPressed: updatePassword,
                        text: S.of(context).changePassword,
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
