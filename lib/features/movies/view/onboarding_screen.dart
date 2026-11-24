import 'package:flutter/material.dart';
import 'package:movies_app/common/app_colors.dart';
import 'package:movies_app/features/movies/view/onboarding_page.dart';
import 'package:movies_app/features/movies/view_model/onboarding_view_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.onFinish});

  final VoidCallback onFinish;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final OnboardingViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = OnboardingViewModel(onFinish: widget.onFinish);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return PopScope(
          canPop: _viewModel.isFirstPage,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) _viewModel.back();
          },
          child: Scaffold(
            backgroundColor: AppColors.black,
            body: PageView.builder(
              controller: _viewModel.pageController,
              itemCount: _viewModel.items.length,
              onPageChanged: _viewModel.onPageChanged,
              itemBuilder: (_, index) {
                final item = _viewModel.items[index];
                final showBack = _viewModel.shouldShowBackButton(index);

                return OnboardingPage(
                  item: item,
                  onNext: _viewModel.next,
                  onBack: showBack ? _viewModel.back : null,
                );
              },
            ),
          ),
        );
      },
    );
  }
}