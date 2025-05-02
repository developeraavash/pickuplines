import 'package:pickuplines/routes/app_routes.dart';
import 'package:pickuplines/core/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: TAppTheme.darkTheme,
      theme: TAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'Color Blind Test',
      initialRoute: RouteManger.first,
      onGenerateRoute: RouteManger.generateRoute,
    );
  }
}
