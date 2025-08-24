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
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  String errorMessage = "";
  bool isLoading = false;

  void updatePassword() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    final currentPassword = _currentPassword.text.trim();
    final newPassword = _newPassword.text.trim();

    if (currentPassword.isEmpty || newPassword.isEmpty) {
      setState(() {
        errorMessage = "All fields are required.";
        isLoading = false;
      });
      return;
    }

    if (_confirmPassword.text != _newPassword.text) {
      setState(() {
        errorMessage = "Passwords don't match!";
        isLoading = false;
      });
      return;
    }

    try {
      final email = FirebaseAuth.instance.currentUser?.email;

      if (email == null) {
        setState(() {
          errorMessage = "No user is logged in.";
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
            content: Text("Password updated successfully."),
            backgroundColor: Colors.green,
          ),
        );
      }
      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessage = error.message ?? "An error occurred.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(title: Text(S.of(context).changePassword)),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.all(Sizes.padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 15),
                  Image.asset(
                    "assets/images/ResetPasswordIcon.png",
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.width * 0.35,
                  ),
                  const SizedBox(height: 15),
                  Column(
                    children: [
                      CustomInputField(
                        controller: _currentPassword,
                        label: S.of(context).changePassword,
                        obscureText: true,
                      ),
                      CustomInputField(
                        controller: _newPassword,
                        label: S.of(context).newPassword,
                        obscureText: true,
                      ),
                      CustomInputField(
                        controller: _confirmPassword,
                        label: S.of(context).confirmPassword,
                        obscureText: true,
                      ),
                    ],
                  ),

                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: Sizes.small,
                        ),
                      ),
                    ),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : MyButton(
                          onPressed: updatePassword,
                          text: S.of(context).changePassword,
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
