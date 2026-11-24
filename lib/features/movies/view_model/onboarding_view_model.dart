import 'package:flutter/material.dart';
import 'package:movies_app/features/movies/model/onboarding_items.dart';
import 'package:movies_app/features/movies/model/onboarding_model.dart';

class OnboardingViewModel extends ChangeNotifier {
  OnboardingViewModel({required this.onFinish});

  final VoidCallback onFinish;

  static const Duration _animationDuration = Duration(milliseconds: 400);

  final PageController pageController = PageController();
  final List<OnboardingModel> items = OnboardingItems.items;

  int _currentPage = 0;
  int get currentPage => _currentPage;

  bool get isFirstPage => _currentPage == 0;
  bool get isLastPage => _currentPage == items.length - 1;

  bool shouldShowBackButton(int index) {
    if (index == 0) return false;
    if (items[index].title == 'Discover Movies') return false;
    return true;
  }

  void onPageChanged(int index) {
    if (_currentPage == index) return;
    _currentPage = index;
    notifyListeners();
  }

  void next() {
    if (isLastPage) {
      onFinish();
      return;
    }
    pageController.nextPage(
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );
  }

  void back() {
    if (isFirstPage) return;
    pageController.previousPage(
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}