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

  void deleteAccount() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    final email = _controllerEmail.text.trim();
    final password = _controllerPassword.text.trim();

    // Validation check
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "Both fields are required.";
        isLoading = false;
      });
      return;
    }

    try {
      await authServices.value.deleteAccount(email: email, password: password);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Account Deleted."),
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
      appBar: AppBar(title: Text(S.of(context).deleteAccount)),
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
                  Image.asset(
                    "assets/images/DeletingAccountIcon.png",
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.width * 0.35,
                  ),
                  Column(
                    children: [
                      InputFields(
                        controllerEmail: _controllerEmail,
                        controllerPassword: _controllerPassword,
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
                    ],
                  ),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : MyButton(
                          text: S.of(context).deleteAccount,
                          onPressed: deleteAccount,
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

class InputFields extends StatelessWidget {
  const InputFields({
    super.key,
    required TextEditingController controllerEmail,
    required TextEditingController controllerPassword,
  }) : _controllerEmail = controllerEmail,
       _controllerPassword = controllerPassword;

  final TextEditingController _controllerEmail;
  final TextEditingController _controllerPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInputField(
          controller: _controllerEmail,
          label: S.of(context).email,
        ),
        CustomInputField(
          controller: _controllerPassword,
          label: S.of(context).password,
          obscureText: true,
        ),
      ],
    );
  }
}
