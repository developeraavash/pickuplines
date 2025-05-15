// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:pickuplines/core/theme/theme.dart';
// import 'package:pickuplines/l18n/app_localizations.dart';
// import 'package:pickuplines/features/first_line/controller/first_line_controller.dart';
// import 'package:pickuplines/features/favourite/controller/favorites_controller.dart';
// import 'package:pickuplines/features/home/controller/flirt_services.dart';
// import 'package:pickuplines/routes/app_routes.dart';

// class App extends StatefulWidget {
//   const App({super.key});

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   Locale? _locale;
//   ThemeMode _themeMode = ThemeMode.system;

//   void setLocale(Locale locale) {
//     setState(() {
//       _locale = locale;
//     });
//   }

//   void setThemeMode(ThemeMode mode) {
//     setState(() {
//       _themeMode = mode;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//       ),
//     );

//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return MultiProvider(
//           providers: [
//             ChangeNotifierProvider(create: (_) => FirstLineController()),
//             ChangeNotifierProvider(create: (_) => FavoritesController()),
//             ChangeNotifierProvider(create: (_) => FlirtServices()),
//           ],
//           child: MaterialApp(
//             debugShowCheckedModeBanner: false,
//             locale: _locale,
//             themeMode: _themeMode,
//             localizationsDelegates: const [
//               AppLocalizations.delegate,
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             supportedLocales: const [
//               Locale('en'), // English
//               Locale('np'), // Nepali
//               Locale('es'), // Spanish
//             ],
//             theme: CAppTheme.lightTheme,
//             darkTheme: CAppTheme.darkTheme,
//             initialRoute: RouteManger.home,
//             onGenerateRoute: RouteManger.generateRoute,
//             builder: (context, child) {
//               return LocaleAndThemeProvider(
//                 setLocale: setLocale,
//                 setThemeMode: setThemeMode,
//                 themeMode: _themeMode,
//                 child: child!,
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// class LocaleAndThemeProvider extends InheritedWidget {
//   final void Function(Locale) setLocale;
//   final void Function(ThemeMode) setThemeMode;
//   final ThemeMode themeMode;

//   const LocaleAndThemeProvider({
//     super.key,
//     required this.setLocale,
//     required this.setThemeMode,
//     required this.themeMode,
//     required super.child,
//   });

//   static LocaleAndThemeProvider? of(BuildContext context) =>
//       context.dependOnInheritedWidgetOfExactType<LocaleAndThemeProvider>();

//   @override
//   bool updateShouldNotify(LocaleAndThemeProvider oldWidget) =>
//       themeMode != oldWidget.themeMode;
// }
