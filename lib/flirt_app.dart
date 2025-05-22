import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pickuplines/aLoadFunc/upload_data.dart';
import 'package:pickuplines/core/theme/theme.dart';
import 'package:pickuplines/core/utils/services/preferences_service.dart';
import 'package:pickuplines/l18n/app_localizations.dart';
import 'package:pickuplines/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:pickuplines/features/first_line/controller/first_line_controller.dart';

class FlirtApp extends StatefulWidget {
  const FlirtApp({super.key});

  @override
  State<FlirtApp> createState() => _FlirtAppState();
}

class _FlirtAppState extends State<FlirtApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;
  final firstLineController = FirstLineController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await uploadAllData(); // Upload data to Firebase
    await firstLineController.loadCategories(); // Load categories after upload
  }

  Future<void> _loadPreferences() async {
    final savedTheme = await PreferencesService.getThemeMode();
    final savedLanguage = await PreferencesService.getLanguage();

    setState(() {
      _themeMode = savedTheme;
      if (savedLanguage != null) {
        _locale = Locale(savedLanguage);
      }
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
    PreferencesService.saveLanguage(locale.languageCode);
  }

  void setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
    PreferencesService.saveThemeMode(mode);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirstLineController>(
          create: (_) => firstLineController,
        ),
      ],
      child: MaterialApp(
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
          Locale('es'), // Spanish
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
      ),
    );
  }
}

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
