import 'package:beuty_support/core/constants/themes.dart';
import 'package:flutter/material.dart';

class ProfileServices extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const ProfileServices({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: Theme.of(context).textTheme.titleSmall),
            Icon(Icons.arrow_forward_ios, size: Sizes.medium),
          ],
        ),
      ),
    );
  }
}
