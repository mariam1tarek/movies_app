import 'package:flutter/material.dart';
import 'package:movies_app/common/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.onToggleObscure,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;

  final VoidCallback? onToggleObscure;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      onFieldSubmitted: onSubmitted,
      style: const TextStyle(color: AppColors.white, fontSize: 16),
      cursorColor: AppColors.yellow,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.white, fontSize: 16),
        filled: true,
        fillColor: AppColors.gray,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        prefixIcon: Icon(prefixIcon, color: AppColors.white),
        suffixIcon: onToggleObscure == null
            ? null
            : IconButton(
                onPressed: onToggleObscure,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: AppColors.white,
                ),
              ),
        errorStyle: const TextStyle(color: AppColors.red),
        border: _border(Colors.transparent),
        enabledBorder: _border(Colors.transparent),
        focusedBorder: _border(AppColors.yellow),
        errorBorder: _border(AppColors.red),
        focusedErrorBorder: _border(AppColors.red),
      ),
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: 1.2),
      );
}
