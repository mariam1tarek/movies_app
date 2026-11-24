import 'package:flutter/material.dart';
import 'package:movies_app/common/app_colors.dart';

/// "Don't Have Account ? Create One" / "Already Have Account ? Login"
class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({
    super.key,
    required this.text,
    required this.actionLabel,
    required this.onTap,
  });

  final String text;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: const TextStyle(color: AppColors.white, fontSize: 14)),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionLabel,
            style: const TextStyle(
              color: AppColors.yellow,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
