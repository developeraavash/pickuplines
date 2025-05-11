import 'package:flutter/material.dart';

class RouteManger {
  static const String first = '/first';
  static const String second = '/second';
  static const String third = '/third';
  static const String splashScreen = '/splashScreen';
  //! Route generator method
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case second:
        return MaterialPageRoute(
          builder: (_) => const Center(child: Text("second page")),
        );
      case third:
        return MaterialPageRoute(
          builder: (_) => const Center(child: Text("third page")),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Center(child: Text("default")),
        );
    }
  }
}
