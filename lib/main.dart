import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickuplines/core/theme/theme.dart';
import 'package:pickuplines/routes/app_routes.dart';
import 'package:pickuplines/l18n/app_localizations.dart';

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
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('es'), // Spanish
      ],

      title: 'Daily Flirts',

      darkTheme: CAppTheme.darkTheme,
      theme: CAppTheme.lightTheme,
      initialRoute: RouteManger.home,
      onGenerateRoute: RouteManger.generateRoute,
    );
  }
}
