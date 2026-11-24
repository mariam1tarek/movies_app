import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_app/common/app_colors.dart';
import 'package:movies_app/common/app_routes.dart';
import 'package:movies_app/common/localization/locale_view_model.dart';
import 'package:movies_app/features/movies/repository/auth_repository.dart';
import 'package:movies_app/features/movies/view/forgot_password_screen.dart';
import 'package:movies_app/features/movies/view/login_screen.dart';
import 'package:movies_app/features/movies/view/onboarding_screen.dart';
import 'package:movies_app/features/movies/view/register_screen.dart';
import 'package:movies_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeViewModel = LocaleViewModel.instance;
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    return ListenableBuilder(
      listenable: localeViewModel,
      builder: (context, _) {
        return MaterialApp(
          title: 'Movies App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColors.black,
          ),
          locale: localeViewModel.locale,
          supportedLocales: LocaleViewModel.supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.onboarding,
          routes: {
            AppRoutes.onboarding: (ctx) => OnboardingScreen(
              onFinish: () =>
                  Navigator.pushReplacementNamed(ctx, AppRoutes.login),
            ),
            AppRoutes.login: (_) => const LoginScreen(),
            AppRoutes.register: (_) => const RegisterScreen(),
            AppRoutes.forgotPassword: (_) => const ForgotPasswordScreen(),
            // TODO: استبدلي الـ placeholder ده بصفحة الـ Home
            AppRoutes.home: (_) => const _TempHomeScreen(),
          },
        );
      },
    );
  }
}

class _TempHomeScreen extends StatefulWidget {
  const _TempHomeScreen();

  @override
  State<_TempHomeScreen> createState() => _TempHomeScreenState();
}

class _TempHomeScreenState extends State<_TempHomeScreen> {
  final AuthRepository _authRepository = AuthRepository();
  bool _isSigningOut = false;

  Future<void> _signOut() async {
    setState(() => _isSigningOut = true);
    try {
      await _authRepository.signOut();
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.login,
            (route) => false,
      );
    } finally {
      if (mounted) {
        setState(() => _isSigningOut = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: _isSigningOut ? null : _signOut,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Home'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isSigningOut ? null : _signOut,
              icon: const Icon(Icons.logout),
              label: Text(_isSigningOut ? 'Signing out...' : 'Logout'),
            ),
          ],
        ),
      ),
    );
  }
}