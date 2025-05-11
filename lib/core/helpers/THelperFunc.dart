import 'package:flutter/material.dart';

class Thelperfunc {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
