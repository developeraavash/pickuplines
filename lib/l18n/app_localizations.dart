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

  /// No description provided for @drivingLicense.
  ///
  /// In en, this message translates to:
  /// **'Driving License'**
  String get drivingLicense;

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World man'**
  String get helloWorld;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language '**
  String get selectLanguage;

  /// No description provided for @categoryaPlusB.
  ///
  /// In en, this message translates to:
  /// **'Category A+B'**
  String get categoryaPlusB;

  /// No description provided for @categoryaPlusBSub.
  ///
  /// In en, this message translates to:
  /// **'Light Vekhicles and MoterCycle'**
  String get categoryaPlusBSub;

  /// No description provided for @categoryA.
  ///
  /// In en, this message translates to:
  /// **'Category A'**
  String get categoryA;

  /// No description provided for @categoryASub.
  ///
  /// In en, this message translates to:
  /// **'Motercycle'**
  String get categoryASub;

  /// No description provided for @categoryB.
  ///
  /// In en, this message translates to:
  /// **'Category B'**
  String get categoryB;

  /// No description provided for @categoryBSub.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get categoryBSub;

  /// No description provided for @categoryC.
  ///
  /// In en, this message translates to:
  /// **'Category C'**
  String get categoryC;

  /// No description provided for @categoryCSub.
  ///
  /// In en, this message translates to:
  /// **'Courrier'**
  String get categoryCSub;

  /// No description provided for @categoryD.
  ///
  /// In en, this message translates to:
  /// **'Category D'**
  String get categoryD;

  /// No description provided for @categoryDSub.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get categoryDSub;

  /// No description provided for @noQuestionAvailable.
  ///
  /// In en, this message translates to:
  /// **'No questions available'**
  String get noQuestionAvailable;

  /// No description provided for @timeLeft.
  ///
  /// In en, this message translates to:
  /// **'Time Left'**
  String get timeLeft;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @circulationSecurityUrgentMissionVehicles.
  ///
  /// In en, this message translates to:
  /// **'Circulation, security, urgent mission vehicles'**
  String get circulationSecurityUrgentMissionVehicles;

  /// No description provided for @dangerSigns.
  ///
  /// In en, this message translates to:
  /// **'Danger Signs'**
  String get dangerSigns;

  /// No description provided for @givingWay.
  ///
  /// In en, this message translates to:
  /// **'Giving way, defensive driving and pedestrians'**
  String get givingWay;

  /// No description provided for @indicationSigns.
  ///
  /// In en, this message translates to:
  /// **'Indication Signs'**
  String get indicationSigns;

  /// No description provided for @obligationSigns.
  ///
  /// In en, this message translates to:
  /// **'Obligation signs'**
  String get obligationSigns;

  /// No description provided for @physicalCondition.
  ///
  /// In en, this message translates to:
  /// **'Physical condition of the driver, alcohol, drugs and medications'**
  String get physicalCondition;

  /// No description provided for @prohibitionSigns.
  ///
  /// In en, this message translates to:
  /// **'Prohibition Signs'**
  String get prohibitionSigns;

  /// No description provided for @speedOtherManeuvers.
  ///
  /// In en, this message translates to:
  /// **'Speed,other maneuvers, speed constraints'**
  String get speedOtherManeuvers;

  /// No description provided for @stoppingParkingAndCrossing.
  ///
  /// In en, this message translates to:
  /// **'Stopping, parking and crossing vehicles, overtaking'**
  String get stoppingParkingAndCrossing;

  /// No description provided for @titlesObtainingRevalidation.
  ///
  /// In en, this message translates to:
  /// **'Titles, obtaining, revalidation, civil and criminal liability, against ordinations, cassation'**
  String get titlesObtainingRevalidation;

  /// No description provided for @trafficLights.
  ///
  /// In en, this message translates to:
  /// **'Traffic lights, road markings, other signs'**
  String get trafficLights;

  /// No description provided for @trafficroutesAndAdverse.
  ///
  /// In en, this message translates to:
  /// **'Traffic routes and adverse environmental conditions'**
  String get trafficroutesAndAdverse;

  /// No description provided for @yieldSigns.
  ///
  /// In en, this message translates to:
  /// **'Yield Signs'**
  String get yieldSigns;

  /// No description provided for @protectiveEquipment.
  ///
  /// In en, this message translates to:
  /// **'Protective Equipment'**
  String get protectiveEquipment;

  /// No description provided for @roadClassification.
  ///
  /// In en, this message translates to:
  /// **'Road Classification'**
  String get roadClassification;

  /// No description provided for @vehicleComponents.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Components'**
  String get vehicleComponents;

  /// No description provided for @visibilityInRelation.
  ///
  /// In en, this message translates to:
  /// **'Visibility InRelation'**
  String get visibilityInRelation;

  /// No description provided for @classificationConstituents.
  ///
  /// In en, this message translates to:
  /// **'Classification Constituents'**
  String get classificationConstituents;

  /// No description provided for @dangerSings.
  ///
  /// In en, this message translates to:
  /// **'Danger Sings'**
  String get dangerSings;

  /// No description provided for @drivingLicensesObtaining.
  ///
  /// In en, this message translates to:
  /// **'Driving Licenses Obtaining'**
  String get drivingLicensesObtaining;

  /// No description provided for @lightingPassengers.
  ///
  /// In en, this message translates to:
  /// **'Lighting Passengers'**
  String get lightingPassengers;

  /// No description provided for @otherManeuvers.
  ///
  /// In en, this message translates to:
  /// **'Other Maneuvers'**
  String get otherManeuvers;

  /// No description provided for @overTaking.
  ///
  /// In en, this message translates to:
  /// **'Overtaking'**
  String get overTaking;

  /// No description provided for @specificPrescription.
  ///
  /// In en, this message translates to:
  /// **'Specific Prescription'**
  String get specificPrescription;

  /// No description provided for @speed.
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get speed;

  /// No description provided for @stoppingParking.
  ///
  /// In en, this message translates to:
  /// **'Stopping Parking'**
  String get stoppingParking;

  /// No description provided for @trafficLightsPavement.
  ///
  /// In en, this message translates to:
  /// **'Traffic Lights Pavement'**
  String get trafficLightsPavement;

  /// No description provided for @trafficRoutesAdverse.
  ///
  /// In en, this message translates to:
  /// **'Traffic Routes Adverse'**
  String get trafficRoutesAdverse;

  /// No description provided for @trafficSafety.
  ///
  /// In en, this message translates to:
  /// **'Traffic Safety'**
  String get trafficSafety;

  /// No description provided for @documentsThatDriver.
  ///
  /// In en, this message translates to:
  /// **'Documents That Driver'**
  String get documentsThatDriver;

  /// No description provided for @drivingAndRestPeriods.
  ///
  /// In en, this message translates to:
  /// **'Driving and Rest Periods'**
  String get drivingAndRestPeriods;

  /// No description provided for @environmentalProtection.
  ///
  /// In en, this message translates to:
  /// **'Environmental Protection and Safety Equipment'**
  String get environmentalProtection;

  /// No description provided for @logistics.
  ///
  /// In en, this message translates to:
  /// **' Logistics (types, use, reading and maintenance)'**
  String get logistics;

  /// No description provided for @maintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get maintenance;

  /// No description provided for @transportOfGoods.
  ///
  /// In en, this message translates to:
  /// **'Transport of Goods'**
  String get transportOfGoods;

  /// No description provided for @vehicleBasics.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Basics'**
  String get vehicleBasics;

  /// No description provided for @vehicleClassification.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Classification and Periodic Inspections'**
  String get vehicleClassification;

  /// No description provided for @passengerTransport.
  ///
  /// In en, this message translates to:
  /// **'Passenger Transport'**
  String get passengerTransport;

  /// No description provided for @classificationVehicleCharacteristics.
  ///
  /// In en, this message translates to:
  /// **'Classification, vehicle characteristics'**
  String get classificationVehicleCharacteristics;

  /// No description provided for @drivingSchool.
  ///
  /// In en, this message translates to:
  /// **'Driving School'**
  String get drivingSchool;

  /// No description provided for @learntoDriveSafely.
  ///
  /// In en, this message translates to:
  /// **'Learn to Drive Safely'**
  String get learntoDriveSafely;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @drivingSchoolApp.
  ///
  /// In en, this message translates to:
  /// **'Driving School App'**
  String get drivingSchoolApp;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'1.0.0'**
  String get version;

  /// No description provided for @copyRightSmait.
  ///
  /// In en, this message translates to:
  /// **'© 2024 Smait Software'**
  String get copyRightSmait;

  /// No description provided for @allGuide.
  ///
  /// In en, this message translates to:
  /// **'Learn Driving'**
  String get allGuide;

  /// No description provided for @h.
  ///
  /// In en, this message translates to:
  /// **''**
  String get h;
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
