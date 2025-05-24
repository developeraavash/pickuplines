import 'package:flutter/material.dart';
import 'package:pickuplines/main_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScreen(); // Allow direct access to main screen
  }
}
