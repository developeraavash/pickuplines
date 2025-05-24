import 'package:flutter/material.dart';
import '../models/login_data.dart';

class AuthController extends ChangeNotifier {
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<void> login(BuildContext context, LoginData loginData) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login failed: ${e.toString()}')));
    }
  }

  void navigateToRegister(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

  void navigateToForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, '/forgotPassword');
  }
}
