import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  String errorMessage = "";
  bool isLoading = false;

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  Future<void> deleteAccount() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    final email = _controllerEmail.text.trim();
    final password = _controllerPassword.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = S.of(context).allfieldsrequired;
        isLoading = false;
      });
      return;
    }

    try {
      await authServices.value.deleteAccount(email: email, password: password);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).accountdeleted),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessage = error.message ?? S.of(context).unexpectederror;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = S.of(context).unexpectederror;
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
          icon: const Icon(Icons.arrow_back),
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
                  Icons.delete_forever,
                  size: screenWidth * 0.2,
                  color: Colors.redAccent,
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  S.of(context).deleteaccount,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  S.of(context).entertodelete,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.5,
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
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomInputField(
                  label: S.of(context).password,
                  controller: _controllerPassword,
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
                  ),
                ],
                SizedBox(height: screenHeight * 0.03),
                isLoading
                    ? const CircularProgressIndicator(color: Colors.redAccent)
                    : MyButton(
                        onPressed: deleteAccount,
                        text: S.of(context).deleteaccount,
                        backgroundColor: Colors.redAccent,
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
