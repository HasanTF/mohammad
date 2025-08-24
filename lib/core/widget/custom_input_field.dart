import 'package:beuty_support/core/constants/themes.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Function(String)? onChanged; // Added onChanged callback

  const CustomInputField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.onChanged, // Added to constructor
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: _obscure,
          onChanged: widget.onChanged, // Pass onChanged to TextField
          decoration: InputDecoration(
            labelText: widget.label,
            prefixIcon: widget.prefixIcon != null
                ? IconTheme(
                    data: IconThemeData(color: Colors.white, size: Sizes.large),
                    child: widget.prefixIcon!,
                  )
                : null,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                      size: Sizes.large,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
