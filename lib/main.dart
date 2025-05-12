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

class FlirtApp extends StatefulWidget {
  const FlirtApp({super.key});

  @override
  State<FlirtApp> createState() => _FlirtAppState();
}

class _FlirtAppState extends State<FlirtApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.light;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      themeMode: _themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('np'), // Spanish
      ],
      darkTheme: CAppTheme.darkTheme,
      theme: CAppTheme.lightTheme,
      initialRoute: RouteManger.home,
      onGenerateRoute: RouteManger.generateRoute,
      builder: (context, child) {
        return LocaleAndThemeProvider(
          setLocale: setLocale,
          setThemeMode: setThemeMode,
          themeMode: _themeMode,
          child: child!,
        );
      },
    );
  }
}

// InheritedWidget to provide setLocale and setThemeMode
class LocaleAndThemeProvider extends InheritedWidget {
  final void Function(Locale) setLocale;
  final void Function(ThemeMode) setThemeMode;
  final ThemeMode themeMode;

  const LocaleAndThemeProvider({
    super.key,
    required this.setLocale,
    required this.setThemeMode,
    required this.themeMode,
    required super.child,
  });

  static LocaleAndThemeProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LocaleAndThemeProvider>();

  @override
  bool updateShouldNotify(LocaleAndThemeProvider oldWidget) =>
      themeMode != oldWidget.themeMode;
}
