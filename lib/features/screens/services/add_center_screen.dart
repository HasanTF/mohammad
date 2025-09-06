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

  // قائمة الخدمات المتاحة
  final List<String> allServices = [
    "Haircut",
    "Makeup",
    "Massage",
    "Nails",
    "Skincare",
  ];

  // الخدمات المختارة
  List<String> selectedServices = [];

  @override
  void dispose() {
    _centerName.dispose();
    _centerLocation.dispose();
    _centerDescription.dispose();
    _centerImageUrl.dispose();
    _centerPhoneNumber.dispose();
    super.dispose();
  }

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

    if (selectedServices.isEmpty) {
      setState(() {
        errorMessage = 'Please select at least one service.';
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
        'centerPhoneNumber': _centerPhoneNumber.text.trim(),
        'services': selectedServices, // حفظ الخدمات المختارة
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Center added successfully!\nIt will appear once admins approve it!',
            ),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    } catch (error) {
      setState(() {
        errorMessage = "Failed to add center";
        isLoading = false;
      });
    } finally {
      setState(() {
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
          /// الجزء العلوي (الأيقونة + العنوان + النص التوضيحي)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.store_mall_directory_outlined,
                  size: screenWidth * 0.2,
                  color: AppColors.secondaryDark,
                  semanticLabel: "Center icon",
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  "Add New Center",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Fill the fields below to request\nadding your center",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

          /// الجزء السفلي (Container)
          Container(
            height: screenHeight * 0.62,
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomInputField(
                    controller: _centerName,
                    label: S.of(context).centerName,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomInputField(
                    controller: _centerLocation,
                    label: S.of(context).centerLocation,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomInputField(
                    controller: _centerPhoneNumber,
                    label: S.of(context).centerPhoneNumber,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomInputField(
                    controller: _centerDescription,
                    label: S.of(context).centerDescription,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomInputField(
                    controller: _centerImageUrl,
                    label: S.of(context).centerImage,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Services",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(height: 5),
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: allServices.map((service) {
                      final isSelected = selectedServices.contains(service);
                      return FilterChip(
                        label: Text(
                          service,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        selected: isSelected,
                        backgroundColor: AppColors.primary.withAlpha(100),
                        selectedColor: AppColors.secondaryDark.withOpacity(0.2),
                        checkmarkColor: AppColors.secondaryDark,
                        side: BorderSide.none,

                        onSelected: (value) {
                          setState(() {
                            if (value) {
                              selectedServices.add(service);
                            } else {
                              selectedServices.remove(service);
                            }
                          });
                        },
                      );
                    }).toList(),
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
                          onPressed: addNewCenter,
                          text: "Add New Center",
                          backgroundColor: AppColors.secondaryDark,
                          textColor: AppColors.textPrimary,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
