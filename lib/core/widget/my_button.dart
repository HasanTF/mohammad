import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;

  const MyButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle =
        (textStyle ?? Theme.of(context).textTheme.labelMedium)?.copyWith(
          color: textColor,
        );

    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                backgroundColor ?? Theme.of(context).colorScheme.primary,
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: textColor ?? Colors.white),
                const SizedBox(width: 5),
              ],
              Text(text, style: effectiveTextStyle),
            ],
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
