import 'dart:ui';

import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCenterScreen extends StatefulWidget {
  const AddCenterScreen({super.key});

  @override
  State<AddCenterScreen> createState() => _AddCenterScreenState();
}

class _AddCenterScreenState extends State<AddCenterScreen> {
  final TextEditingController _centerName = TextEditingController();
  final TextEditingController _centerLocation = TextEditingController();
  final TextEditingController _centerDescription = TextEditingController();
  final TextEditingController _centerImageUrl = TextEditingController();
  final TextEditingController _centerPhoneNumber = TextEditingController();

  String errorMessage = "";
  bool isLoading = false;

  Future<void> addNewCenter() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    if (_centerName.text.isEmpty ||
        _centerLocation.text.isEmpty ||
        _centerDescription.text.isEmpty ||
        _centerImageUrl.text.isEmpty ||
        _centerPhoneNumber.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields.';
        isLoading = false;
      });
      return;
    }
    try {
      await FirebaseFirestore.instance.collection('centers').add({
        'centerName': _centerName.text.trim(),
        'centerLocation': _centerLocation.text.trim(),
        'centerDescription': _centerDescription.text.trim(),
        'centerImageUrl': _centerImageUrl.text.trim(),
        'centerRating': 0,
        "centerPhoneNumber": _centerPhoneNumber.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      });

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = "Failed to add center";
        isLoading = false;
      });
    } finally {
      if (mounted) {
        Navigator.pop(context);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Center added successfully!\nIt will appear once admins approve it!',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(S.of(context).addNewCenter)),
      body: Stack(
        children: [
          SizedBox.expand(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Image.asset(
                "assets/images/mybadlife.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black54),
          Padding(
            padding: EdgeInsets.all(Sizes.padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                CustomInputField(
                  controller: _centerName,
                  label: S.of(context).centerName,
                ),
                SizedBox(height: 20),
                CustomInputField(
                  controller: _centerLocation,
                  label: S.of(context).centerLocation,
                ),
                SizedBox(height: 20),
                CustomInputField(
                  controller: _centerPhoneNumber,
                  label: S.of(context).centerPhoneNumber,
                ),
                SizedBox(height: 20),
                CustomInputField(
                  controller: _centerDescription,
                  label: S.of(context).centerDescription,
                ),
                SizedBox(height: 20),
                CustomInputField(
                  controller: _centerImageUrl,
                  label: S.of(context).centerImage,
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
                Spacer(),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : MyButton(
                        text: S.of(context).addNewCenter,
                        onPressed: addNewCenter,
                      ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
