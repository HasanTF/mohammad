import 'dart:ui';
import 'package:beuty_support/core/constants/themes.dart';
import 'package:beuty_support/features/screens/services/edit_review_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  final String userId;

  const NotificationButton({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        final notifications = snapshot.data?.docs ?? [];

        final unreadNotifications = notifications
            .where((notif) => notif['read'] == false)
            .toList();
        final unreadCount = unreadNotifications.length;

        return SizedBox(
          width: 48,
          height: 48,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    width: 48, // تحديد الحجم هنا
                    height: 48,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white54, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondaryDark.withAlpha(100),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_outlined,
                        size: 28,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black45, blurRadius: 1)],
                      ),
                      onPressed: () async {
                        // تعليم كل الإشعارات غير المقروءة كمقروءة
                        for (var notif in unreadNotifications) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(userId)
                              .collection('notifications')
                              .doc(notif.id)
                              .update({'read': true});
                        }

                        // حساب موقع الزر لعرض الـ PopupMenu
                        final RenderBox button =
                            context.findRenderObject() as RenderBox;
                        final overlay =
                            Overlay.of(context).context.findRenderObject()
                                as RenderBox;

                        final buttonPosition = button.localToGlobal(
                          Offset.zero,
                          ancestor: overlay,
                        );
                        final buttonSize = button.size;

                        final position = RelativeRect.fromLTRB(
                          buttonPosition.dx,
                          buttonPosition.dy + buttonSize.height,
                          buttonPosition.dx + buttonSize.width,
                          0,
                        );

                        final selectedNotif = await showMenu<DocumentSnapshot>(
                          context: context,
                          position: position,
                          items: notifications.isEmpty
                              ? [
                                  const PopupMenuItem(
                                    child: Text("لا توجد إشعارات"),
                                  ),
                                ]
                              : notifications
                                    .map(
                                      (notif) =>
                                          PopupMenuItem<DocumentSnapshot>(
                                            value: notif,
                                            child: Row(
                                              children: [
                                                if (notif['read'] == false)
                                                  const Icon(
                                                    Icons.circle,
                                                    size: 8,
                                                    color: Colors.red,
                                                  )
                                                else
                                                  const SizedBox(width: 8),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    notif['message'],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          notif['read'] == false
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                      color:
                                                          notif['read'] == false
                                                          ? Colors.black
                                                          : Colors.grey[600],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                    )
                                    .toList(),
                        );

                        // بعد اختيار النوتيفيكيشن
                        if (selectedNotif != null) {
                          if (selectedNotif['message'].toString().startsWith(
                            "تم رفض مراجعتك",
                          )) {
                            final reviewId = selectedNotif['reviewId'];

                            final reviewSnap = await FirebaseFirestore.instance
                                .collection('centerReviews')
                                .doc(reviewId)
                                .get();

                            if (reviewSnap.exists && context.mounted) {
                              final hasEdited =
                                  reviewSnap['hasEdited'] ?? false;

                              if (hasEdited) {
                                // منع تعديل الريفيو مرة ثانية
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "لقد قمت بتعديل هذا الريفيو مسبقاً، لا يمكن التعديل مرة أخرى.",
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              // فتح شاشة التعديل إذا لم يتم التعديل سابقاً
                              Future.delayed(Duration.zero, () {
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EditReviewScreen(
                                        docId: reviewId,
                                        oldComment: reviewSnap['comment'],
                                        oldRating: reviewSnap['rating'],
                                        rejectionMessage:
                                            reviewSnap['rejectionMessage'],
                                        centerId: reviewSnap['centerId'],
                                      ),
                                    ),
                                  );
                                }
                              });
                            }
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              // Badge للإشعارات غير المقروءة
              if (unreadCount > 0)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
