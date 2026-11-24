import 'package:flutter/material.dart';
import 'package:movies_app/common/app_colors.dart';
import 'package:movies_app/features/movies/model/onboarding_model.dart';
import 'package:movies_app/features/movies/view/onboarding_content.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
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
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          item.image,
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
        ),
        const _BottomGradient(),
        Align(
          alignment: Alignment.bottomCenter,
          child: OnboardingContent(
            item: item,
            onNext: onNext,
            onBack: onBack,
          ),
        ),
      ],
    );
  }
}

class _BottomGradient extends StatelessWidget {
  const _BottomGradient();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.35, 0.72, 1.0],
          colors: [
            Colors.transparent,
            Color(0xB3121312),
            AppColors.black,
          ],
        ),
      ),
    );
  }
}