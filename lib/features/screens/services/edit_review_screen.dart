import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditReviewScreen extends StatefulWidget {
  final String docId;
  final String oldComment;
  final int oldRating;
  final String rejectionMessage;
  final String centerId;

  const EditReviewScreen({
    super.key,
    required this.docId,
    required this.oldComment,
    required this.oldRating,
    required this.rejectionMessage,
    required this.centerId,
  });

  @override
  State<EditReviewScreen> createState() => _EditReviewScreenState();
}

class _EditReviewScreenState extends State<EditReviewScreen> {
  late TextEditingController _reviewController;
  late int rating;
  String? centerName;
  String? centerImage;
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    _reviewController = TextEditingController(text: widget.oldComment);
    rating = widget.oldRating;
    _fetchCenterInfo();
  }

  Future<void> _fetchCenterInfo() async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection('centers')
          .doc(widget.centerId)
          .get();

      setState(() {
        if (snap.exists) {
          centerName = snap['centerName'] ?? S.of(context).unknownclinic;
          centerImage = snap['centerImageUrl'];
        } else {
          centerName = S.of(context).unknownclinic;
        }
        isLoading = false;
      });
    } catch (_) {
      setState(() {
        centerName = S.of(context).unexpectederror;
        centerImage = null;
        isLoading = false;
      });
    }
  }

  Future<void> _resubmitReview() async {
    if (_reviewController.text.trim().isEmpty || rating == 0) {
      setState(() => errorMessage = S.of(context).pleaseselectrating);
      return;
    }

    setState(() {
      errorMessage = "";
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('centerReviews')
          .doc(widget.docId)
          .update({
            'comment': _reviewController.text.trim(),
            'rating': rating,
            'status': 'pending',
            'updatedAt': Timestamp.now(),
            "hasEdited": true,
          });

      _showSnackBar("Review resubmitted for approval.", Colors.green);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (_) {
      setState(() => errorMessage = S.of(context).failedtoresubmitreview);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showSnackBar(String message, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  Widget _buildErrorMessage() {
    if (errorMessage.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        errorMessage,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.redAccent),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRatingStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        return IconButton(
          onPressed: () => setState(() => rating = i + 1),
          icon: Icon(
            Icons.star_rounded,
            size: 32,
            color: i < rating ? Colors.amber : Colors.grey[400],
          ),
        );
      }),
    );
  }

  Widget _buildCenterCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: centerImage != null
              ? Image.network(
                  centerImage!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "assets/images/placeholder.png",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
        ),
        title: Text(
          centerName ?? "...",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(S.of(context).editandresubmit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.06),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    S.of(context).editreview,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    S.of(context).resubmitreview,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  // Rejection Message
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      border: Border.all(color: Colors.red.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 28,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            S.of(context).rejectionreason +
                                (widget.rejectionMessage),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.red.shade800),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildCenterCard(),
                  const SizedBox(height: 20),
                  // Review TextField
                  TextField(
                    controller: _reviewController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: S.of(context).yourreview,
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildRatingStars(),
                  _buildErrorMessage(),
                  const SizedBox(height: 20),
                  MyButton(
                    text: S.of(context).resubmitreview,
                    onPressed: _resubmitReview,
                    backgroundColor: AppColors.secondaryDark,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          if (isLoading)
            const Positioned.fill(
              child: ColoredBox(
                color: Colors.black26,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}
