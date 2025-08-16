import 'package:beuty_support/core/constants/colors.dart';
import 'package:beuty_support/core/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CenterDetails extends StatefulWidget {
  const CenterDetails({super.key});

  @override
  State<CenterDetails> createState() => _CenterDetailsState();
}

class _CenterDetailsState extends State<CenterDetails> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? center =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (center == null) {
      return Scaffold(
        backgroundColor: AppColors.cWhite,
        body: const Center(child: Text("Error: No center data provided.")),
      );
    }

    final size = MediaQuery.of(context).size;
    final kWidth = size.width;
    final kHeight = size.height;

    return Scaffold(
      backgroundColor: AppColors.cWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.cWhite,
        elevation: 1,
        title: Text(
          center['centerName'] ?? 'Center Name',
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizes.medium,
            fontWeight: FontWeight.bold,
            fontFamily: "Delius",
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CenterImage(
                kWidth: kWidth,
                kHeight: kHeight,
                imageUrl: center['centerImageUrl'] ?? '',
              ),
              CenterDetal(kWidth: kWidth, data: center),
              WriteReviewButton(kWidth: kWidth, centerId: center['id'] ?? ''),
              Reviews(
                kWidth: kWidth,
                kHeight: kHeight,
                centerId: center['id'] ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Reviews extends StatefulWidget {
  final double kWidth;
  final double kHeight;
  final String centerId;

  const Reviews({
    super.key,
    required this.kWidth,
    required this.kHeight,
    required this.centerId,
  });

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool _isLoading = false;
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    checkAdmin();
  }

  Future<void> checkAdmin() async {
    bool admin = await checkIfUserIsAdmin();
    setState(() {
      _isAdmin = admin;
    });
  }

  Future<bool> checkIfUserIsAdmin() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return false;

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    if (userDoc.exists) {
      final data = userDoc.data();
      return data?['isAdmin'] == true;
    }
    return false;
  }

  void _refresh() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _deleteReview(String reviewId) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Deleting review...")));

    try {
      await FirebaseFirestore.instance
          .collection("centerReviews")
          .doc(reviewId)
          .delete();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Review Deleted Successfully"),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[200],
          content: Text("Failed to delete review: $error"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.centerId.isEmpty) {
      return Text(
        "Invalid center ID.",
        style: TextStyle(color: AppColors.cLightGrey),
      );
    }

    return Padding(
      padding: EdgeInsets.all(widget.kWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Reviews",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.medium,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Delius",
                  shadows: AppShadows.primaryShadow,
                ),
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _refresh,
                tooltip: 'Refresh reviews',
              ),
            ],
          ),
          SizedBox(height: 8),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('centerReviews')
                .where('centerId', isEqualTo: widget.centerId)
                .where('status', isEqualTo: 'approved')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  _isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text(
                      "Error loading reviews: ${snapshot.error}",
                      style: TextStyle(color: AppColors.cLightGrey),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(onPressed: _refresh, child: Text("Retry")),
                  ],
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text(
                  "No reviews yet.",
                  style: TextStyle(color: AppColors.cLightGrey),
                );
              }

              final reviews = snapshot.data!.docs;

              return ListView.builder(
                itemCount: reviews.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final review = reviews[index].data() as Map<String, dynamic>;

                  final rating = (review['rating'] ?? 0).toInt();
                  final username = review['username'] ?? "Anonymous";
                  final comment = review['comment'] ?? "";
                  final Timestamp timestamp =
                      review['createdAt'] ?? Timestamp.now();
                  final date = timestamp.toDate();

                  return Container(
                    padding: EdgeInsets.symmetric(
                      vertical: widget.kHeight * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                "assets/images/avatar.jpg",
                              ),
                              backgroundColor: AppColors.cPrimary.withAlpha(51),
                            ),
                            SizedBox(width: 18.0),
                            Column(
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
                                Row(
                                  children: List.generate(5, (i) {
                                    return Icon(
                                      Icons.star,
                                      color: i < rating
                                          ? Colors.amber
                                          : Colors.grey,
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
                                ),
                                if (_isAdmin)
                                  InkWell(
                                    onTap: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text("Confirm Deletion"),
                                          content: Text(
                                            "Are you sure you want to delete this review?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(false),
                                              child: Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(true),
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true) {
                                        _deleteReview(reviews[index].id);
                                      }
                                    },
                                    child: Text(
                                      "Delete Review",
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
                        Text(
                          "${date.month}/${date.day}/${date.year}",
                          style: TextStyle(
                            color: AppColors.cLightGrey,
                            fontSize: Sizes.small,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class WriteReviewButton extends StatelessWidget {
  final dynamic kWidth;
  final dynamic centerId;

  const WriteReviewButton({
    super.key,
    required this.kWidth,
    required this.centerId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: kWidth * 0.05),
      decoration: BoxDecoration(
        color: AppColors.cPrimary,
        borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/writeareview', arguments: centerId);
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          overlayColor: Colors.transparent,
        ),
        child: Text(
          'Write a Review',
          style: TextStyle(fontSize: Sizes.medium, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CenterDetal extends StatefulWidget {
  final dynamic kWidth;
  final Map<String, dynamic> data;
  const CenterDetal({super.key, required this.kWidth, required this.data});

  @override
  State<CenterDetal> createState() => _CenterDetalState();
}

class _CenterDetalState extends State<CenterDetal> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.kWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data['centerName'] ?? 'No Name',
            style: TextStyle(
              color: Colors.black,
              fontSize: Sizes.medium * 1.1,
              fontWeight: FontWeight.bold,
              fontFamily: "Delius",
            ),
          ),
          Row(
            children: [
              ...List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: index < (widget.data['centerRating'] ?? 0).toInt()
                      ? Colors.amber
                      : Colors.grey,
                  size: 18.0,
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                (widget.data['centerRating']?.toStringAsFixed(1) ?? '0.0'),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                widget.data['centerAddress'] ?? '',
                style: TextStyle(color: AppColors.cLightGrey, fontSize: 16.0),
              ),
            ],
          ),
          if (widget.data['centerLocation'] != null)
            Text(
              widget.data['centerLocation'],
              style: TextStyle(color: AppColors.cLightGrey, fontSize: 16.0),
            ),
          if (widget.data['centerPhone'] != null)
            Text(
              widget.data['centerPhone'],
              style: TextStyle(color: AppColors.cLightGrey, fontSize: 16.0),
            ),
          if (widget.data['centerDescription'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                widget.data['centerDescription'],
                style: TextStyle(color: Colors.black87, fontSize: Sizes.small),
              ),
            ),
        ],
      ),
    );
  }
}

class CenterImage extends StatelessWidget {
  final double kWidth;
  final double kHeight;
  final String imageUrl;

  const CenterImage({
    super.key,
    required this.kWidth,
    required this.kHeight,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: kWidth,
      height: kHeight * 0.22,
      errorBuilder: (context, error, stackTrace) => Container(
        width: kWidth,
        height: kHeight * 0.22,
        color: Colors.grey[300],
        alignment: Alignment.center,
        child: Icon(Icons.broken_image, size: 40),
      ),
    );
  }
}
