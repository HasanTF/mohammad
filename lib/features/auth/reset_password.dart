import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:beuty_support/generated/l10n.dart';
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

  void resetPassword() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    final email = _controllerEmail.text.trim();

    // Validation check
    if (email.isEmpty) {
      setState(() {
        errorMessage = "field is required.";
        isLoading = false;
      });
      return;
    }

    try {
      await authServices.value.resetPassword(email: email);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Check you email box."),
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).resetPassword,
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: Sizes.large,
            fontWeight: FontWeight.bold,
            fontFamily: "Delius",
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.all(Sizes.padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 10.0),
                    Image.asset(
                      "assets/images/ResetPasswordIcon.png",
                      fit: BoxFit.contain,
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.primary,
                        hintText: S.of(context).email,
                        hintStyle: TextStyle(color: AppColors.primary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppBorderRadius.borderR,
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    Text(
                      errorMessage,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: Sizes.small,
                      ),
                    ),
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : MyButton(
                            onPressed: resetPassword,
                            text: S.of(context).resetPassword,
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
