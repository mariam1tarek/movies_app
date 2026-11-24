import 'package:flutter/material.dart';
import 'package:movies_app/common/app_colors.dart';
import 'package:movies_app/common/widgets/primary_button.dart';
import 'package:movies_app/common/widgets/secondary_button.dart';
import 'package:movies_app/features/movies/model/onboarding_model.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.item,
    required this.onNext,
    this.onBack,
  });

  final OnboardingModel item;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 24, 20, 20 + bottomInset),
      decoration: item.isIntro
          ? null
          : BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.black.withValues(alpha: 0.72),
            AppColors.black.withValues(alpha: 0.94),
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontSize: item.isIntro ? 36 : 24,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          if (item.description != null) ...[
            const SizedBox(height: 16),
            Text(
              item.description!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: item.isIntro
                    ? AppColors.white.withValues(alpha: 0.6)
                    : AppColors.white,
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 24),
          PrimaryButton(label: item.nextLabel, onPressed: onNext),
          if (onBack != null) ...[
            const SizedBox(height: 16),
            SecondaryButton(label: 'Back', onPressed: onBack!),
          ],
        ],
      ),
    );
  }
}