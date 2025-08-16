import 'package:beuty_support/core/widget/review_card.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:beuty_support/core/constants/sizes.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.horizontal,
            vertical: 8,
          ),
          child: Text(
            S.of(context).pendingReviews,
            style: TextStyle(
              color: Colors.black,
              fontSize: Sizes.medium,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('centerReviews')
                .where("status", isEqualTo: "pending")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data?.docs ?? [];

              if (docs.isEmpty) {
                return Center(child: Text(S.of(context).noPendingReviews));
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: AppPadding.horizontal,
                ),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final data = docs[index].data() as Map<String, dynamic>;
                  final docId = docs[index].id;

                  return ReviewCard(
                    username: data['username'] ?? 'Unknown',
                    rating: data['rating'] ?? 0,
                    comment: data['comment'] ?? '',
                    centerId: data['centerId'],
                    docId: docId,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
