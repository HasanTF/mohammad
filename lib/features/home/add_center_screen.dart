import 'package:beuty_support/core/constants/colors.dart';
import 'package:beuty_support/core/constants/sizes.dart';
import 'package:beuty_support/core/widget/custom_button.dart';
import 'package:beuty_support/core/widget/custom_input_field.dart';
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
      backgroundColor: AppColors.cWhite,
      appBar: AppBar(
        backgroundColor: AppColors.cWhite,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).addNewCenter,
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.large,
            fontWeight: FontWeight.bold,
            fontFamily: "Delius",
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constrains) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constrains.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.horizontal,
                  vertical: AppPadding.vertical,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        CustomInputField(
                          controller: _centerName,
                          label: S.of(context).centerName,
                        ),
                        CustomInputField(
                          controller: _centerLocation,
                          label: S.of(context).centerLocation,
                        ),
                        CustomInputField(
                          controller: _centerPhoneNumber,
                          label: S.of(context).centerPhoneNumber,
                        ),
                        CustomInputField(
                          controller: _centerDescription,
                          label: S.of(context).centerDescription,
                        ),
                        CustomInputField(
                          controller: _centerImageUrl,
                          label: S.of(context).centerImage,
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
                        : CustomButton(
                            text: S.of(context).addNewCenter,
                            onPressed: addNewCenter,
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
