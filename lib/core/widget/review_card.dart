import 'package:beuty_support/core/constants/colors.dart';
import 'package:beuty_support/core/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String username;
  final int rating;
  final String comment;
  final String centerId;
  final String docId;

  const ReviewCard({
    super.key,
    required this.username,
    required this.rating,
    required this.comment,
    required this.centerId,
    required this.docId,
  });

  Future<void> _approveReview(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('centerReviews')
          .doc(docId)
          .update({'status': 'approved'});

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Review approved successfully"),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to approve review: $error")),
        );
      }
    }
  }

  Future<void> _declineReview(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('pendingReviews')
          .doc(docId)
          .delete();

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Review declined and deleted")));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to decline review: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('centers')
          .doc(centerId)
          .get(),
      builder: (context, snapshot) {
        String centerName = " ";
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          centerName = data?['centerName'] ?? "Unknown Center";
        }

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: AppPadding.vertical / 2,
            horizontal: AppPadding.horizontal,
          ),
          margin: EdgeInsets.only(bottom: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(1, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/avatar.jpg"),
                backgroundColor: AppColors.cPrimary.withAlpha(51),
              ),
              SizedBox(width: 18.0),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.medium * 0.75,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      centerName,
                      style: TextStyle(
                        color: AppColors.cPrimary,
                        fontSize: Sizes.small,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          Icons.star,
                          color: i < rating ? Colors.amber : Colors.grey,
                          size: 14.0,
                        );
                      }),
                    ),
                    SizedBox(height: 4),
                    Text(
                      comment,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.small,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  TextButton(
                    onPressed: () => _approveReview(context),
                    child: Text(
                      "Approve",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: Sizes.extraSmall,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Confirm Rejection"),
                          content: Text(
                            "Are you sure you want to decline and delete this review?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(
                                "Decline",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      if (confirm == true) _declineReview(context);
                    },
                    child: Text(
                      "Decline",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: Sizes.extraSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
