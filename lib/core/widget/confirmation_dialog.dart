import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final Color confirmColor;
  final Color cancelColor;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = "Confirm",
    this.cancelText = "Cancel",
    this.confirmColor = Colors.red,
    this.cancelColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          content: Text(
            content,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText, style: TextStyle(color: cancelColor)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmText, style: TextStyle(color: confirmColor)),
            ),
          ],
        ),
      ],
    );
  }
}
