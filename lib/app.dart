import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickuplines/features/first_line/controller/first_line_controller.dart';
import 'package:pickuplines/features/favourite/controller/favorites_controller.dart';
import 'package:pickuplines/features/home/controller/flirt_services.dart';
import 'package:pickuplines/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => FirstLineController()),
            ChangeNotifierProvider(create: (_) => FavoritesController()),
            ChangeNotifierProvider(create: (_) => FlirtServices()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              cardColor: Colors.white,
              colorScheme: ColorScheme.light(
                primary: Color(0xFF5EAFC0),
                secondary: Color(0xFFFF6B9E),
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Color(0xFF121212),
              cardColor: Color(0xFF1E1E1E),
              colorScheme: ColorScheme.dark(
                primary: Color(0xFF5EAFC0),
                secondary: Color(0xFFFF6B9E),
              ),
            ),
            home: const MainScreen(),
          ),
        );
      },
    );
  }
}
