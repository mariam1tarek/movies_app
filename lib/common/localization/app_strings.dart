import 'package:flutter/widgets.dart';

/// نصوص بسيطة (EN / AR). الـ of(context) بتعمل dependency على الـ Locale
/// فالشاشة بتتعمل rebuild أوتوماتيك لما اللغة تتغير.
class AppStrings {
  AppStrings._(this._isAr);

  final bool _isAr;

  static AppStrings of(BuildContext context) =>
      AppStrings._(Localizations.localeOf(context).languageCode == 'ar');

  String _t(String en, String ar) => _isAr ? ar : en;

  String get email => _t('Email', 'البريد الإلكتروني');
  String get password => _t('Password', 'كلمة المرور');
  String get confirmPassword => _t('Confirm Password', 'تأكيد كلمة المرور');
  String get name => _t('Name', 'الاسم');
  String get phoneNumber => _t('Phone Number', 'رقم الهاتف');
  String get login => _t('Login', 'تسجيل الدخول');
  String get forgetPassword => _t('Forget Password ?', 'نسيت كلمة المرور ؟');
  String get forgetPasswordTitle => _t('Forget Password', 'نسيت كلمة المرور');
  String get dontHaveAccount => _t("Don't Have Account ? ", 'ليس لديك حساب ؟ ');
  String get createOne => _t('Create One', 'أنشئ حساب');
  String get or => _t('OR', 'أو');
  String get loginWithGoogle => _t('Login With Google', 'الدخول بواسطة جوجل');
  String get register => _t('Register', 'تسجيل');
  String get avatar => _t('Avatar', 'الصورة الرمزية');
  String get createAccount => _t('Create Account', 'إنشاء حساب');
  String get alreadyHaveAccount => _t('Already Have Account ? ', 'لديك حساب بالفعل ؟ ');
  String get verifyEmail => _t('Verify Email', 'تأكيد البريد');
  String get resetEmailSent => _t(
        'Password reset link has been sent to your email',
        'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك',
      );

  String authError(String code) {
    switch (code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return _t('Invalid email or password', 'البريد أو كلمة المرور غير صحيحة');
      case 'invalid-email':
        return _t('Invalid email address', 'البريد الإلكتروني غير صالح');
      case 'email-already-in-use':
        return _t('This email is already registered', 'هذا البريد مسجل بالفعل');
      case 'weak-password':
        return _t('Password is too weak', 'كلمة المرور ضعيفة');
      case 'user-disabled':
        return _t('This account has been disabled', 'تم تعطيل هذا الحساب');
      case 'too-many-requests':
        return _t('Too many attempts, try again later', 'محاولات كثيرة، حاول لاحقاً');
      case 'network-request-failed':
        return _t('Check your internet connection', 'تأكد من اتصالك بالإنترنت');
      default:
        return _t('Something went wrong, try again', 'حدث خطأ ما، حاول مرة أخرى');
    }
  }
}
