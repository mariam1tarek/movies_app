import 'package:flutter/material.dart';

class LocaleViewModel extends ChangeNotifier {
  LocaleViewModel._();
  static final LocaleViewModel instance = LocaleViewModel._();

  static const List<Locale> supportedLocales = [Locale('en'), Locale('ar')];

  Locale _locale = const Locale('en');
  Locale get locale => _locale;
  bool get isArabic => _locale.languageCode == 'ar';

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }
}
