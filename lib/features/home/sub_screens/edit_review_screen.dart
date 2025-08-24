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
      if (snap.exists) {
        setState(() {
          centerName = snap['centerName'];
          centerImage = snap['centerImageUrl'];
          isLoading = false;
        });
      } else {
        setState(() {
          centerName = "Unknown Center";
          centerImage = null;
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        centerName = "Error loading center";
        centerImage = null;
        isLoading = false;
      });
    }
  }

  Future<void> _resubmitReview() async {
    try {
      await FirebaseFirestore.instance
          .collection('centerReviews')
          .doc(widget.docId)
          .update({
            'comment': _reviewController.text.trim(),
            'rating': rating,
            'status': 'pending',
            'updatedAt': Timestamp.now(),
          });

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Review resubmitted for approval."),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to resubmit: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Rejected Review"),
        elevation: 0,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // رسالة الرفض
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
                            "Your review was rejected:\n${widget.rejectionMessage}",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: Colors.red.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // بطاقة السنتر
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
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
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "Edit and resubmit your review",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // حقل تعديل الريفيو
                  TextField(
                    controller: _reviewController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: "Your Review",
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // النجوم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      return IconButton(
                        onPressed: () {
                          setState(() => rating = i + 1);
                        },
                        icon: Icon(
                          Icons.star_rounded,
                          size: 32,
                          color: i < rating ? Colors.amber : Colors.grey[400],
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 30),

                  // زر إعادة الإرسال
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.send_rounded),
                      onPressed: _resubmitReview,
                      label: const Text("Resubmit Review"),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
