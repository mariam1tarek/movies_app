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
import 'package:movies_app/features/movies/view/widgets/avatar_picker.dart';
import 'package:movies_app/features/movies/view_model/register_view_model.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final RegisterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = RegisterViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _onRegister() async {
    final success = await _viewModel.register();
    if (!mounted) return;
    if (success) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
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
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.yellow),
        title: Text(
          s.register,
          style: const TextStyle(color: AppColors.yellow, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: _viewModel.formKey,
                child: Column(
                  children: [
                    AvatarPicker(
                      controller: _viewModel.avatarController,
                      avatars: RegisterViewModel.avatars,
                      onChanged: _viewModel.onAvatarChanged,
                      onTap: _viewModel.selectAvatar,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      s.avatar,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _viewModel.nameController,
                      hint: s.name,
                      prefixIcon: Icons.badge_outlined,
                      keyboardType: TextInputType.name,
                      validator: AppValidators.validateFullName,
                    ),
                    const SizedBox(height: 16),
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
                      validator: AppValidators.validatePassword,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _viewModel.confirmPasswordController,
                      hint: s.confirmPassword,
                      prefixIcon: Icons.lock_rounded,
                      obscureText: _viewModel.obscureConfirm,
                      onToggleObscure: _viewModel.toggleObscureConfirm,
                      validator: (val) => AppValidators.validateConfirmPassword(
                        val,
                        _viewModel.passwordController.text,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _viewModel.phoneController,
                      hint: s.phoneNumber,
                      prefixIcon: Icons.phone_rounded,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      validator: AppValidators.validatePhoneNumber,
                      onSubmitted: (_) => _onRegister(),
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      label: s.createAccount,
                      isLoading: _viewModel.isLoading,
                      onPressed: _onRegister,
                    ),
                    const SizedBox(height: 20),
                    AuthFooterLink(
                      text: s.alreadyHaveAccount,
                      actionLabel: s.login,
                      onTap: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 20),
                    const LanguageSwitch(),
                    const SizedBox(height: 16),
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
