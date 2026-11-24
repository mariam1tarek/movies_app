import 'package:flutter/material.dart';
import 'package:movies_app/common/app_colors.dart';

void showAuthSnackBar(BuildContext context, String message, {bool isError = true}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: AppColors.white)),
        backgroundColor: isError ? AppColors.red : AppColors.gray,
        behavior: SnackBarBehavior.floating,
      ),
    );
}
