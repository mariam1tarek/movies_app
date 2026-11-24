import 'package:movies_app/features/movies/model/onboarding_model.dart';


abstract final class OnboardingItems {
  static const List<OnboardingModel> items = [
    OnboardingModel(
      image: "assets/images/poster1.png",
      title: 'Find Your Next Favorite Movie Here',
      description:
      'Get access to a huge library of movies to suit all tastes. You will surely like it.',
      nextLabel: 'Explore Now',
      isIntro: true,
    ),
    OnboardingModel(
      image: "assets/images/poster2.png",
      title: 'Discover Movies',
      description:
      'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
      nextLabel: 'Next',
    ),
    OnboardingModel(
      image: "assets/images/poster3.png",
      title: 'Explore All Genres',
      description:
      'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
      nextLabel: 'Next',
    ),
    OnboardingModel(
      image: "assets/images/poster4.png",
      title: 'Create Watchlists',
      description:
      'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
      nextLabel: 'Next',
    ),
    OnboardingModel(
      image: "assets/images/poster5.png",
      title: 'Rate, Review, and Learn',
      description:
      'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies with your reviews.',
      nextLabel: 'Next',
    ),
    OnboardingModel(
      image: "assets/images/poster6.png",
      title: 'Start Watching Now',
      nextLabel: 'Finish',
    ),
  ];
}