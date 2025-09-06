import 'package:beuty_support/core/constants/themes.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;

  const CustomInputField({
    super.key,
    required this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.autofillHints,
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
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscure,
      onChanged: widget.onChanged,
      validator: widget.validator,
      autofillHints: widget.autofillHints,
      cursorColor: AppColors.secondaryDark,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.secondaryDark,
        ),
        floatingLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: Sizes.small,
          fontWeight: FontWeight.w700,
          color: AppColors.secondaryDark,
        ),
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconTheme(
                  data: IconThemeData(
                    color: AppColors.secondaryDark,
                    size: Sizes.medium,
                  ),
                  child: widget.prefixIcon!,
                ),
              )
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.secondaryDark,
                  size: Sizes.medium,
                ),
                onPressed: _toggleVisibility,
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
          borderSide: BorderSide(color: AppColors.secondaryDark, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
          borderSide: BorderSide(color: AppColors.secondaryDark, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
          borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
          borderSide: BorderSide(color: AppColors.textSecondary, width: 1.5),
        ),
        errorStyle: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.redAccent, fontSize: 12),
      ),
    );
  }
}
