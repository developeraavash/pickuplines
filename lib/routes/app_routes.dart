import 'package:flutter/material.dart';
import 'package:pickuplines/features/auth/views/login_page.dart';
import 'package:pickuplines/features/auth/wrapper/auth_wrapper.dart';
import 'package:pickuplines/main_screen.dart';

class RouteManger {
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String wrapper = '/wrapper';

  //! Route generator method
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case wrapper:
        return MaterialPageRoute(builder: (_) => const AuthWrapper());
      case home:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const ModernLoginPage());
      default:
        return MaterialPageRoute(builder: (_) => const MainScreen());
    }
  }
}
