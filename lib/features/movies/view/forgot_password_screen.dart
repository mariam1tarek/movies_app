import 'package:flutter/material.dart';
import 'package:movies_app/common/app_colors.dart';
import 'package:movies_app/common/localization/app_strings.dart';
import 'package:movies_app/common/widgets/app_validators.dart';
import 'package:movies_app/common/widgets/custom_text_field.dart';
import 'package:movies_app/common/widgets/primary_button.dart';
import 'package:movies_app/features/movies/view/widgets/auth_snackbar.dart';
import 'package:movies_app/features/movies/view_model/forgot_password_view_model.dart';



class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final ForgotPasswordViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ForgotPasswordViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _onVerify() async {
    final success = await _viewModel.sendResetEmail();
    if (!mounted) return;
    final s = AppStrings.of(context);
    if (success) {
      showAuthSnackBar(context, s.resetEmailSent, isError: false);
      Navigator.pop(context);
    } else if (_viewModel.errorCode != null) {
      showAuthSnackBar(context, s.authError(_viewModel.errorCode!));
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
          s.forgetPasswordTitle,
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
                    const SizedBox(height: 24),
                    Image.asset(
                      'assets/images/forgot_password.png',
                      height: MediaQuery.sizeOf(context).height * 0.4,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      controller: _viewModel.emailController,
                      hint: s.email,
                      prefixIcon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      validator: AppValidators.validateEmail,
                      onSubmitted: (_) => _onVerify(),
                    ),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      label: s.verifyEmail,
                      isLoading: _viewModel.isLoading,
                      onPressed: _onVerify,
                    ),
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
