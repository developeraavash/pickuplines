import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pickuplines/flirt_app.dart';
import 'package:pickuplines/features/home/controller/flirt_services.dart';
import 'package:pickuplines/features/first_line/controller/first_line_controller.dart';
import 'package:pickuplines/features/favourite/controller/favorites_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FlirtServices()),
        ChangeNotifierProvider(create: (_) => FirstLineController()),
        ChangeNotifierProvider(create: (_) => FavoritesController()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: const FlirtApp(),
      ),
    ),
  );
}
