import 'package:beuty_support/core/constants/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatefulWidget {
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

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  Future<void> _approveReview() async {
    try {
      // Approving Reviews
      await FirebaseFirestore.instance
          .collection('centerReviews')
          .doc(widget.docId)
          .update({'status': 'approved'});

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Review approved successfully"),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to approve review: $error")),
      );
    }
  }

  Future<void> _declineReview(String rejectionMessage) async {
    final reviewRef = FirebaseFirestore.instance
        .collection('centerReviews')
        .doc(widget.docId);

    try {
      // Rejecting with rejection message
      await reviewRef.update({
        'status': 'rejected',
        'rejectionMessage': rejectionMessage,
        'updatedAt': Timestamp.now(),
      });

      final reviewSnapshot = await reviewRef.get();
      final userId = reviewSnapshot['userId'];

      // Notifying user for rejection + إضافة reviewId
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .add({
            'message': "تم رفض مراجعتك: $rejectionMessage",
            'reviewId': widget.docId, // 👈 مهم جداً
            'timestamp': Timestamp.now(),
            'read': false,
          });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Review declined. The user has been notified."),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to decline review: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('centers')
          .doc(widget.centerId)
          .get(),
      builder: (context, snapshot) {
        String centerName = " ";
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          centerName = data?['centerName'] ?? "Unknown Center";
        }

        return Container(
          padding: EdgeInsets.all(Sizes.padding),
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
                radius: 35,
                backgroundImage: AssetImage("assets/images/avatar.jpg"),
                backgroundColor: AppColors.secondary.withAlpha(51),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 2),
                    Text(
                      centerName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          Icons.star,
                          color: i < widget.rating ? Colors.amber : Colors.grey,
                          size: 14.0,
                        );
                      }),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.comment,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: _approveReview,
                    child: Text(
                      "Approve",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: Sizes.medium,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final TextEditingController messageController =
                          TextEditingController();

                      final rejectMessage = await showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Reject Review"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Please enter a message for the user:"),
                              SizedBox(height: 10),
                              TextField(
                                controller: messageController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: "Rejection message",
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("Cancel"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pop(messageController.text.trim());
                              },
                              child: Text("Reject"),
                            ),
                          ],
                        ),
                      );

                      if (!mounted) return;

                      if (rejectMessage != null && rejectMessage.isNotEmpty) {
                        await _declineReview(rejectMessage);
                      }
                    },
                    child: Text(
                      "Decline",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: Sizes.medium,
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
