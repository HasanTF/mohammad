import 'package:beuty_support/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:beuty_support/core/constants/colors.dart';
import 'package:beuty_support/core/constants/sizes.dart';

class WriteAReview extends StatefulWidget {
  const WriteAReview({super.key});

  @override
  State<WriteAReview> createState() => _WriteAReviewState();
}

class _WriteAReviewState extends State<WriteAReview> {
  int selectedRating = 0;

  final TextEditingController reviewController = TextEditingController();

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a rating and write a review.")),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You must be logged in to submit a review.")),
      );
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Submitting review...")));

    final review = {
      'centerId': centerId,
      'username': user.displayName ?? user.email ?? 'Anonymous',
      'rating': selectedRating,
      'comment': comment,
      'createdAt': Timestamp.now(),
      'status': "pending",
    };

    try {
      await FirebaseFirestore.instance.collection('centerReviews').add(review);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to submit review. Please try again."),
        ),
      );
    } finally {
      // ignore: control_flow_in_finally
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Review submitted successfully! \nit will appear once the admin approve it",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final kWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).writeAReview,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Delius",
            fontWeight: FontWeight.bold,
            fontSize: Sizes.medium,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How was your experience?",
                style: TextStyle(
                  fontSize: Sizes.medium * 1.1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Row(
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
                          ? Colors.amber
                          : AppColors.cLightGrey,
                      size: 30,
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              Text(
                "Your Review",
                style: TextStyle(
                  fontSize: Sizes.medium,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: reviewController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: "Write something about your visit...",
                  filled: true,
                  fillColor: AppColors.cSecondary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.borderR,
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.borderR,
                      ),
                    ),
                  ),
                  onPressed: submitReview,
                  child: Text(
                    "Submit Review",
                    style: TextStyle(
                      color: AppColors.cWhite,
                      fontSize: Sizes.medium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
