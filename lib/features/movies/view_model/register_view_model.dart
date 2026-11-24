import 'package:flutter/material.dart';
import 'package:movies_app/common/base_view_model.dart';
import 'package:movies_app/features/movies/model/user_model.dart';
import 'package:movies_app/features/movies/repository/auth_repository.dart';

class RegisterViewModel extends BaseViewModel {
  RegisterViewModel({AuthRepository? repository})
      : _repository = repository ?? AuthRepository();

  static const int _initialAvatar = 1;

  final AuthRepository _repository;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  final PageController avatarController = PageController(
    viewportFraction: 0.38,
    initialPage: _initialAvatar,
  );
  static const List<String> avatars = [
    'assets/images/avater1.png',
    'assets/images/avater2.png',
    'assets/images/avater3.png',
    'assets/images/avater4.png',
    'assets/images/avater5.png',
    'assets/images/avater6.png',
    'assets/images/avater7.png',
    'assets/images/avater8.png',
    'assets/images/avater9.png',
  ];

  int _selectedAvatar = _initialAvatar;
  int get selectedAvatar => _selectedAvatar;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _obscureConfirm = true;
  bool get obscureConfirm => _obscureConfirm;

  void onAvatarChanged(int index) {
    if (_selectedAvatar == index) return;
    _selectedAvatar = index;
    notifyListeners();
  }

  void selectAvatar(int index) {
    avatarController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void toggleObscurePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleObscureConfirm() {
    _obscureConfirm = !_obscureConfirm;
    notifyListeners();
  }

  Future<bool> register() async {
    if (!(formKey.currentState?.validate() ?? false)) return false;

    final user = UserModel(
      uid: '',
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      avatar: avatars[_selectedAvatar],
    );

    return runGuarded(
      () => _repository.signUp(user: user, password: passwordController.text),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    avatarController.dispose();
    super.dispose();
  }
}
