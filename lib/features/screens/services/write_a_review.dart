import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WriteAReview extends StatefulWidget {
  const WriteAReview({super.key});

  @override
  State<WriteAReview> createState() => _WriteAReviewState();
}

class _WriteAReviewState extends State<WriteAReview> {
  int selectedRating = 0;
  final TextEditingController reviewController = TextEditingController();
  String errorMessage = "";
  bool isLoading = false;
  late String centerId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    centerId = ModalRoute.of(context)!.settings.arguments as String;
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  Future<void> submitReview() async {
    final comment = reviewController.text.trim();

    if (selectedRating == 0 || comment.isEmpty) {
      setState(() {
        errorMessage = S.of(context).pleaseselectrating;
      });
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        errorMessage = S.of(context).mustbelogged;
      });
      return;
    }

    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    final review = {
      'centerId': centerId,
      'userId': user.uid,
      'username': user.displayName ?? user.email ?? 'Anonymous',
      'rating': selectedRating,
      'comment': comment,
      'createdAt': Timestamp.now(),
      'status': "pending",
    };

    try {
      await FirebaseFirestore.instance.collection('centerReviews').add(review);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(S.of(context).reviewsubmitted),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    } catch (error) {
      setState(() {
        errorMessage = S.of(context).reviewnotsubmitted;
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// الجزء العلوي (أيقونة + عنوان + شرح)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.rate_review_outlined,
                  size: screenWidth * 0.2,
                  color: AppColors.secondaryDark,
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  S.of(context).writereview,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  S.of(context).tellusexperience,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

          /// الجزء السفلي (Container)
          Container(
            height: screenHeight * 0.55,
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
                  Text(
                    S.of(context).yourrating,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            selectedRating = index + 1;
                          });
                        },
                        icon: Icon(
                          Icons.star,
                          color: index < selectedRating
                              ? AppColors.primary
                              : Colors.black26,
                          size: 30,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextField(
                    controller: reviewController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: S.of(context).writereviewhere,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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
                      ? CircularProgressIndicator(
                          semanticsLabel: S.of(context).loading,
                          color: AppColors.secondaryDark,
                        )
                      : MyButton(
                          onPressed: submitReview,
                          text: S.of(context).submitreview,
                          backgroundColor: AppColors.secondaryDark,
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
