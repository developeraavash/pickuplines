import 'package:pickuplines/core/theme/custom_theme/appbar_theme.dart';
import 'package:pickuplines/core/theme/custom_theme/elevated_button_theme.dart';
import 'package:pickuplines/core/theme/custom_theme/text_feild_theme.dart';
import 'package:pickuplines/core/theme/custom_theme/text_theme.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CAppTheme {
  CAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: CTextTheme.lightTextTheme,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: CAppbarTheme.lightAppBarTheme,
    elevatedButtonTheme: CElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: CTextFeildTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: CTextTheme.darkTextTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: CAppbarTheme.darkAppBarTheme,
    fontFamily: GoogleFonts.poppins().fontFamily,
    elevatedButtonTheme: CElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: CTextFeildTheme.darkInputDecorationTheme,
  );
}
