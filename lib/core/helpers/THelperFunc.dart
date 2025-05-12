import 'package:flutter/material.dart';
import 'package:pickuplines/l18n/app_localizations.dart';

class Thelperfunc {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static AppLocalizations appLocalizations(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}
