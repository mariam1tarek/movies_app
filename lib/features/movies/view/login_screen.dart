import 'package:flutter/material.dart';

import 'package:movies_app/common/app_colors.dart';
import 'package:movies_app/common/app_routes.dart';
import 'package:movies_app/common/localization/app_strings.dart';
import 'package:movies_app/common/widgets/app_validators.dart';
import 'package:movies_app/common/widgets/custom_text_field.dart';
import 'package:movies_app/common/widgets/language_switch.dart';
import 'package:movies_app/common/widgets/primary_button.dart';
import 'package:movies_app/features/movies/view/widgets/auth_footer_link.dart';
import 'package:movies_app/features/movies/view/widgets/auth_snackbar.dart';
import 'package:movies_app/features/movies/view_model/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = LoginViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _handle(Future<bool> Function() action) async {
    final success = await action();
    if (!mounted) return;
    if (success) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else if (_viewModel.errorCode != null) {
      showAuthSnackBar(
        context,
        AppStrings.of(context).authError(_viewModel.errorCode!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Form(
                key: _viewModel.formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Image.asset('assets/images/logo.png', height: 118),
                    const SizedBox(height: 56),
                    CustomTextField(
                      controller: _viewModel.emailController,
                      hint: s.email,
                      prefixIcon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidators.validateEmail,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _viewModel.passwordController,
                      hint: s.password,
                      prefixIcon: Icons.lock_rounded,
                      obscureText: _viewModel.obscurePassword,
                      onToggleObscure: _viewModel.toggleObscurePassword,
                      textInputAction: TextInputAction.done,
                      validator: AppValidators.validatePassword,
                      onSubmitted: (_) => _handle(_viewModel.login),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AppRoutes.forgotPassword,
                        ),
                        child: Text(
                          s.forgetPassword,
                          style: const TextStyle(
                            color: AppColors.yellow,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    PrimaryButton(
                      label: s.login,
                      isLoading: _viewModel.isLoading,
                      onPressed: () => _handle(_viewModel.login),
                    ),
                    const SizedBox(height: 20),
                    AuthFooterLink(
                      text: s.dontHaveAccount,
                      actionLabel: s.createOne,
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.register),
                    ),
                    const SizedBox(height: 20),
                    _OrDivider(label: s.or),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      label: s.loginWithGoogle,
                      onPressed: _viewModel.isLoading
                          ? null
                          : () => _handle(_viewModel.loginWithGoogle),
                      icon: const Icon(Icons.g_mobiledata_rounded, size: 34),
                    ),
                    const SizedBox(height: 24),
                    const LanguageSwitch(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    const line = Expanded(child: Divider(color: AppColors.yellow, thickness: 1));
    return Row(
      children: [
        const SizedBox(width: 40),
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            label,
            style: const TextStyle(color: AppColors.yellow, fontSize: 16),
          ),
        ),
        line,
        const SizedBox(width: 40),
      ],
    );
  }
}
