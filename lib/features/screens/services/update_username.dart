import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:beuty_support/features/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateUsername extends StatefulWidget {
  const UpdateUsername({super.key});

  @override
  State<UpdateUsername> createState() => _UpdateUsernameState();
}

class _UpdateUsernameState extends State<UpdateUsername> {
  final TextEditingController _controllerUsername = TextEditingController();

  String errorMessage = "";
  bool isLoading = false;

  @override
  void dispose() {
    _controllerUsername.dispose();
    super.dispose();
  }

  Future<void> updateUsername() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    final username = _controllerUsername.text.trim();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (username.isEmpty) {
      setState(() {
        errorMessage = "Field is required.";
        isLoading = false;
      });
      return;
    }

    if (userId == null) {
      setState(() {
        errorMessage = "User not logged in.";
        isLoading = false;
      });
      return;
    }

    try {
      /// 1) Update in users collection
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'name': username,
      });

      /// 2) Update in Provider
      if (mounted) {
        Provider.of<UserProvider>(
          context,
          listen: false,
        ).setDisplayName(username);
      }

      /// 3) Update all reviews for this user
      final firestore = FirebaseFirestore.instance;
      final reviewsSnapshot = await firestore
          .collection('centerReviews')
          .where('userId', isEqualTo: userId)
          .get();

      WriteBatch batch = firestore.batch();
      for (var doc in reviewsSnapshot.docs) {
        batch.update(doc.reference, {'username': username});
      }

      if (reviewsSnapshot.docs.isNotEmpty) {
        await batch.commit();
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Username is updated in profile and reviews."),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessage = error.message ?? "An error occurred.";
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
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
                  Icons.person_outline,
                  size: screenWidth * 0.2,
                  color: AppColors.primary,
                  semanticLabel: "User icon",
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  "Update Username",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Enter your new username\nto update your profile and reviews",
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
                  label: "New Username",
                  controller: _controllerUsername,
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
                        onPressed: updateUsername,
                        text: "Update Username",
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
