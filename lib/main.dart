import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickuplines/core/theme/theme.dart';
import 'package:pickuplines/features/home/screens/home_screen.dart';
import 'package:pickuplines/routes/app_routes.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: const FlirtApp(),
    ),
  );
}

class FlirtApp extends StatelessWidget {
  const FlirtApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Quotes',

      darkTheme: CAppTheme.darkTheme,
      theme: CAppTheme.lightTheme,
      initialRoute: RouteManger.home,
      onGenerateRoute: RouteManger.generateRoute,
    );
  }
}
