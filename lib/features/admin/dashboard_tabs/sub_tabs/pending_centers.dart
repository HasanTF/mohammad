import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PendingCenters extends StatefulWidget {
  const PendingCenters({super.key});

  @override
  State<PendingCenters> createState() => _PendingCentersState();
}

class _PendingCentersState extends State<PendingCenters> {
  Future<void> deleteCenter(String centerId) async {
    try {
      await FirebaseFirestore.instance
          .collection("centers")
          .doc(centerId)
          .delete();
    } catch (error) {
      debugPrint("Error deleting center: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('centers')
          .where("status", isEqualTo: "pending")
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          debugPrint("Firestore error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text(S.of(context).noCenters));
        }

        final centers = snapshot.data!.docs;

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(Sizes.padding),
                itemCount: centers.length,
                itemBuilder: (context, index) {
                  final center = centers[index];
                  final data = center.data() as Map<String, dynamic>;
                  final centerData = {...data, 'id': center.id};

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/centerdetails',
                          arguments: centerData,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppBorderRadius.borderR,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                data['centerImageUrl'] ?? '',
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.broken_image, size: 100),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['centerName'] ?? 'No Name',
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: Sizes.small * 1.3,
                                      fontFamily: "Zain",
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (i) => Icon(
                                        Icons.star,
                                        color:
                                            i <
                                                (data['centerRating'] ?? 0)
                                                    .toInt()
                                            ? Colors.amber
                                            : Colors.grey,
                                        size: 20,
                                      ),
                                    )..add(const SizedBox(width: 8)),
                                  ),
                                  Text(
                                    data['centerLocation'] ?? '',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: Sizes.small * 0.75,
                                    ),
                                  ),
                                  Text(
                                    data['centerDescription'] ?? '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizes.small,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection("centers")
                                          .doc(center.id)
                                          .update({"status": "approved"});
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text("Center approved"),
                                          ),
                                        );
                                      }
                                    } catch (error) {
                                      debugPrint(
                                        "Error approving center: $error",
                                      );
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Failed to approve center",
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  },
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
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Are you sure?"),
                                        content: const Text(
                                          "Do you really want to decline this center? This action cannot be undone.",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(
                                              context,
                                            ).pop(false),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: Text(
                                              "Reject",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirm == true) {
                                      try {
                                        await FirebaseFirestore.instance
                                            .collection("centers")
                                            .doc(center.id)
                                            .delete();
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text("Center rejected"),
                                            ),
                                          );
                                        }
                                      } catch (error) {
                                        debugPrint(
                                          "Error deleting center: $error",
                                        );
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Failed to delete center",
                                              ),
                                            ),
                                          );
                                        }
                                      }
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
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
