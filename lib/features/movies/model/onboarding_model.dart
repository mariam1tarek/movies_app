class OnboardingModel {
  const OnboardingModel({
    required this.image,
    required this.title,
    required this.nextLabel,
    this.description,
    this.isIntro = false,
  });

  final String image;
  final String title;
  final String? description;

  final String nextLabel;

  final bool isIntro;
}