import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class BaseViewModel extends ChangeNotifier {
  static const Set<String> _cancelCodes = {
    'canceled',
    'web-context-canceled',
    'popup-closed-by-user',
  };

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? errorCode;

  bool _disposed = false;

  void _setLoading(bool value) {
    _isLoading = value;
    if (!_disposed) notifyListeners();
  }

  Future<bool> runGuarded(Future<void> Function() action) async {
    errorCode = null;
    _setLoading(true);
    try {
      await action();
      return true;
    } on FirebaseAuthException catch (e) {
      if (!_cancelCodes.contains(e.code)) errorCode = e.code;
      return false;
    } catch (_) {
      errorCode = 'unknown';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
