import 'package:beuty_support/core/constants/sizes.dart';
import 'package:beuty_support/core/services/auth_sevices.dart';
import 'package:beuty_support/core/widget/custom_button.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateUsername extends StatefulWidget {
  const UpdateUsername({super.key});

  @override
  State<UpdateUsername> createState() => _UpdateUsernameState();
}

class _UpdateUsernameState extends State<UpdateUsername> {
  final TextEditingController _controllerUsername = TextEditingController();

  String errorMessage = "";
  bool isLoading = false;

  void updateUsername() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    final username = _controllerUsername.text.trim();

    // Validation check
    if (username.isEmpty) {
      setState(() {
        errorMessage = "Field is required.";
        isLoading = false;
      });
      return;
    }

    try {
      await authServices.value.updateUsername(username: username);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Username is updated."),
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).updateUsername,
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
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.horizontal,
                  vertical: AppPadding.vertical,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 16.0),
                    Image.asset(
                      "assets/images/ChangeUsernameIcon.png",
                      fit: BoxFit.contain,
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 16.0),
                    CustomInputField(
                      controller: _controllerUsername,
                      label: S.of(context).newUsername,
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
                        : CustomButton(
                            text: S.of(context).updateUsername,
                            onPressed: updateUsername,
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
