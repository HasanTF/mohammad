import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/core/widget/my_button.dart';
import 'package:beuty_support/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CentersTab extends StatefulWidget {
  const CentersTab({super.key});

  @override
  State<CentersTab> createState() => _CentersTabState();
}

class _CentersTabState extends State<CentersTab> {
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
          .where("status", isEqualTo: "approved")
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
          return Center(child: Text(S.of(context).noclinics));
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
                                      color: AppColors.textPrimary,
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
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 24,
                              ),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      S.of(context).confirmdeletionclinic,
                                    ),
                                    content: Text(
                                      S.of(context).confirmdeletionclinicmsg,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: Text(S.of(context).cancel),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: Text(S.of(context).delete),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  await deleteCenter(center.id);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(Sizes.padding),
                child: MyButton(
                  text: S.of(context).addnewclinic,
                  onPressed: () {
                    Navigator.pushNamed(context, '/addcenterscreen');
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
