import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l18n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @firstLineForHer.
  ///
  /// In en, this message translates to:
  /// **'First line for her'**
  String get firstLineForHer;

  /// No description provided for @conversationStarterThatConnect.
  ///
  /// In en, this message translates to:
  /// **'Conversation Starter That Connect'**
  String get conversationStarterThatConnect;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Quotes'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ve picked some quotes for You'**
  String get appSubtitle;

  /// No description provided for @firstDateSection.
  ///
  /// In en, this message translates to:
  /// **'First Date with Her'**
  String get firstDateSection;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @quotesSection.
  ///
  /// In en, this message translates to:
  /// **'Inspiring Quotes'**
  String get quotesSection;

  /// No description provided for @firstLineforHer.
  ///
  /// In en, this message translates to:
  /// **'First Lines for Her'**
  String get firstLineforHer;

  /// No description provided for @genuine.
  ///
  /// In en, this message translates to:
  /// **'Genuine'**
  String get genuine;

  /// No description provided for @playful.
  ///
  /// In en, this message translates to:
  /// **'Playful'**
  String get playful;

  /// No description provided for @deep.
  ///
  /// In en, this message translates to:
  /// **'Deep'**
  String get deep;

  /// No description provided for @funny.
  ///
  /// In en, this message translates to:
  /// **'Funny'**
  String get funny;

  /// No description provided for @coffeeShop.
  ///
  /// In en, this message translates to:
  /// **'Coffee Shop'**
  String get coffeeShop;

  /// No description provided for @casualAndConfortableSetting.
  ///
  /// In en, this message translates to:
  /// **'Casual and comfortable setting'**
  String get casualAndConfortableSetting;

  /// No description provided for @dinnerDate.
  ///
  /// In en, this message translates to:
  /// **'Dinner Date'**
  String get dinnerDate;

  /// No description provided for @forForRestaurantSetting.
  ///
  /// In en, this message translates to:
  /// **'For a restaurant setting'**
  String get forForRestaurantSetting;

  /// No description provided for @artGallery.
  ///
  /// In en, this message translates to:
  /// **'Art Gallery'**
  String get artGallery;

  /// No description provided for @forTheCreativeConnection.
  ///
  /// In en, this message translates to:
  /// **'For the creative connection'**
  String get forTheCreativeConnection;

  /// No description provided for @walkInThePark.
  ///
  /// In en, this message translates to:
  /// **'Walk in the Park'**
  String get walkInThePark;

  /// No description provided for @casualOutdoorConversation.
  ///
  /// In en, this message translates to:
  /// **'Casual outdoor conversation'**
  String get casualOutdoorConversation;

  /// No description provided for @firstLine.
  ///
  /// In en, this message translates to:
  /// **'Flirt Lines'**
  String get firstLine;

  /// No description provided for @weHavePickedSomeLineFor.
  ///
  /// In en, this message translates to:
  /// **'We have picked some lines for You'**
  String get weHavePickedSomeLineFor;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
