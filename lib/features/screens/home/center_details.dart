import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/widget/confirmation_dialog.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:beuty_support/generated/l10n.dart';
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
        backgroundColor: AppColors.background,
        body: Center(child: Text(S.of(context).noclinicsfound)),
      );
    }

    final size = MediaQuery.of(context).size;
    final kWidth = size.width;
    final kHeight = size.height;

    return Scaffold(
      appBar: AppBar(title: Text(center['centerName'] ?? 'Center Name')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CenterImage(
              kWidth: kWidth,
              kHeight: kHeight,
              imageUrl: center['centerImageUrl'] ?? '',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
              child: Column(
                children: [
                  CenterDetal(kWidth: kWidth, data: center),
                  WriteReviewButton(
                    kWidth: kWidth,
                    centerId: center['id'] ?? '',
                  ),
                  Reviews(
                    kWidth: kWidth,
                    kHeight: kHeight,
                    centerId: center['id'] ?? '',
                  ),
                ],
              ),
            ),
          ],
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
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _deleteReview(String reviewId) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(S.of(context).deletingreview)));

    try {
      await FirebaseFirestore.instance
          .collection("centerReviews")
          .doc(reviewId)
          .delete();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(S.of(context).reviewdeleted),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[200],
          content: Text(S.of(context).failedtodeletereview),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.centerId.isEmpty) {
      return Text(
        S.of(context).invalidclinicid,
        style: TextStyle(color: AppColors.textPrimary),
      );
    }

    return Padding(
      padding: EdgeInsets.all(widget.kWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).reviews,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _refresh,
                tooltip: 'Refresh reviews',
              ),
            ],
          ),
          const SizedBox(height: 8),
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
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text(
                      "Error loading reviews: ${snapshot.error}",
                      style: const TextStyle(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _refresh,
                      child: const Text("Retry"),
                    ),
                  ],
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text(
                  S.of(context).noreviews,
                  style: TextStyle(color: AppColors.textPrimary),
                );
              }

              final reviews = snapshot.data!.docs;

              return ListView.builder(
                itemCount: reviews.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final review = reviews[index].data() as Map<String, dynamic>;

                  final rating = (review['rating'] ?? 0).toInt();
                  final username = review['username'] ?? "Anonymous";
                  final comment = review['comment'] ?? "";
                  final Timestamp timestamp =
                      review['createdAt'] ?? Timestamp.now();
                  final date = timestamp.toDate();

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.secondaryLight,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                            "assets/images/avatar.jpg",
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                        const SizedBox(width: 18.0),

                        // Main content (Flexible)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Username
                              Text(
                                username,
                                style: Theme.of(context).textTheme.bodyLarge,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4),
                              // Rating stars
                              Row(
                                children: List.generate(5, (i) {
                                  return Icon(
                                    Icons.star,
                                    color: i < rating
                                        ? Colors.amber
                                        : Colors.grey,
                                    size: 16.0,
                                  );
                                }),
                              ),
                              const SizedBox(height: 4),
                              // Comment
                              Text(
                                comment,
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                                maxLines:
                                    3, // يسمح بالتفاف التعليق بسطرين/ثلاثة
                              ),
                              if (_isAdmin)
                                InkWell(
                                  onTap: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => ConfirmationDialog(
                                        title: S.of(context).confirmdeleting,
                                        content: S
                                            .of(context)
                                            .confirmdeletingreview,
                                        confirmText: S.of(context).delete,
                                        cancelText: S.of(context).cancel,
                                        confirmColor: Colors.red,
                                        cancelColor: Colors.black,
                                      ),
                                    );

                                    if (confirm == true) {
                                      _deleteReview(reviews[index].id);
                                    }
                                  },
                                  child: Text(
                                    S.of(context).deletereview,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: Sizes.extraSmall,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // Date
                        const SizedBox(width: 12),
                        Text(
                          "${date.month}/${date.day}/${date.year}",
                          style: TextStyle(
                            color: Colors.black87,
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
    return MyButton(
      onPressed: () {
        Navigator.pushNamed(context, '/writeareview', arguments: centerId);
      },
      text: S.of(context).writereview,
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
          /// اسم المركز
          Text(
            widget.data['centerName'] ?? 'No Name',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.black),
          ),

          /// التقييم + العنوان
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
              const SizedBox(width: 10.0),
              Text(
                (widget.data['centerRating']?.toStringAsFixed(1) ?? '0.0'),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                widget.data['centerAddress'] ?? '',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),

          /// الموقع
          if (widget.data['centerLocation'] != null)
            Text(
              widget.data['centerLocation'],
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16.0,
              ),
            ),

          /// رقم الهاتف
          if (widget.data['centerPhone'] != null)
            Text(
              widget.data['centerPhone'],
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16.0,
              ),
            ),

          /// الوصف
          if (widget.data['centerDescription'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                widget.data['centerDescription'],
                style: TextStyle(color: Colors.black87, fontSize: Sizes.small),
              ),
            ),

          /// الخدمات
          if (widget.data['services'] != null &&
              widget.data['services'] is List &&
              (widget.data['services'] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).services,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: (widget.data['services'] as List)
                        .map<Widget>(
                          (service) => Chip(
                            label: Text(service.toString()),
                            backgroundColor: AppColors.secondaryLight.withAlpha(
                              50,
                            ),
                            labelStyle: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
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
        child: const Icon(Icons.broken_image, size: 40),
      ),
    );
  }
}
