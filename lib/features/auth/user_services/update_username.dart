import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:beuty_support/features/providers/user_provider.dart';
import 'package:beuty_support/generated/l10n.dart';
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

  void updateUsername() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    final username = _controllerUsername.text.trim();
    final userId = FirebaseAuth.instance.currentUser?.uid;

    // Validation check
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

      // Adding Provider
      if (mounted) {
        Provider.of<UserProvider>(
          context,
          listen: false,
        ).setDisplayName(username);
      }

      /// 2) Update all reviews for this user
      final firestore = FirebaseFirestore.instance;
      final reviewsSnapshot = await firestore
          .collection('centerReviews') // اسم الكولكشن تبع reviews
          .where('userId', isEqualTo: userId)
          .get();

      WriteBatch batch = firestore.batch();
      int count = 0;

      for (var doc in reviewsSnapshot.docs) {
        batch.update(doc.reference, {'username': username});
        count++;
      }

      if (count > 0) {
        await batch.commit();
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Username is updated in profile and reviews."),
            backgroundColor: Colors.green,
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
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).updateUsername)),
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
                      : MyButton(
                          text: S.of(context).updateUsername,
                          onPressed: updateUsername,
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
