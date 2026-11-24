import 'package:flutter/material.dart';
import 'package:movies_app/common/base_view_model.dart';
import 'package:movies_app/features/movies/repository/auth_repository.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel({AuthRepository? repository})
      : _repository = repository ?? AuthRepository();

  final AuthRepository _repository;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void toggleObscurePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<bool> login() async {
    if (!(formKey.currentState?.validate() ?? false)) return false;
    return runGuarded(
      () => _repository.signIn(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  Future<bool> loginWithGoogle() => runGuarded(_repository.signInWithGoogle);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
