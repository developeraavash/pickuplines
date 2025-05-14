import 'package:flutter/material.dart';
import 'package:pickuplines/app.dart';

class RouteManger {
  static const String home = '/home';
  static const String second = '/second';
  static const String third = '/third';
  static const String splashScreen = '/splashScreen';
  //! Route generator method
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case third:
        return MaterialPageRoute(
          builder: (_) => const Center(child: Text("third page")),
        );

      default:
        return MaterialPageRoute(builder: (_) => const MainScreen());
    }
  }
}
