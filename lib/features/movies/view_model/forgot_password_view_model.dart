import 'package:flutter/material.dart';
import 'package:movies_app/common/base_view_model.dart';
import 'package:movies_app/features/movies/repository/auth_repository.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  ForgotPasswordViewModel({AuthRepository? repository})
      : _repository = repository ?? AuthRepository();

  final AuthRepository _repository;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  Future<bool> sendResetEmail() async {
    if (!(formKey.currentState?.validate() ?? false)) return false;
    return runGuarded(
      () => _repository.sendPasswordResetEmail(emailController.text),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
