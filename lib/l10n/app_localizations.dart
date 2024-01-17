import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @localStorageConnectionError.
  ///
  /// In en, this message translates to:
  /// **'local storage connection error.'**
  String get localStorageConnectionError;

  /// No description provided for @networkConnectionError.
  ///
  /// In en, this message translates to:
  /// **'Network connection error check the internet connection.'**
  String get networkConnectionError;

  /// No description provided for @server404Error.
  ///
  /// In en, this message translates to:
  /// **'Server error 404 (server not found).'**
  String get server404Error;

  /// No description provided for @server400Error.
  ///
  /// In en, this message translates to:
  /// **'Server error 400 (Bad Request).'**
  String get server400Error;

  /// No description provided for @server401Error.
  ///
  /// In en, this message translates to:
  /// **'Server error 401 (Authentication credential).'**
  String get server401Error;

  /// No description provided for @server403Error.
  ///
  /// In en, this message translates to:
  /// **'Server error 403 (have no permission).'**
  String get server403Error;

  /// No description provided for @server500Error.
  ///
  /// In en, this message translates to:
  /// **'Server error 500 (Internal Server Error).'**
  String get server500Error;

  /// No description provided for @unKnownError.
  ///
  /// In en, this message translates to:
  /// **'unKnown error please try again later.'**
  String get unKnownError;

  /// No description provided for @userError.
  ///
  /// In en, this message translates to:
  /// **'Bad Usage Of The App.'**
  String get userError;

  /// No description provided for @phoneUsedBefore.
  ///
  /// In en, this message translates to:
  /// **'this phone number is currently used'**
  String get phoneUsedBefore;

  /// No description provided for @emailUsedBefore.
  ///
  /// In en, this message translates to:
  /// **'this email is currently used'**
  String get emailUsedBefore;

  /// No description provided for @profileSetting.
  ///
  /// In en, this message translates to:
  /// **'profile setting'**
  String get profileSetting;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'about'**
  String get about;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'theme'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'language'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'logout'**
  String get logout;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'search'**
  String get search;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'user'**
  String get user;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'content'**
  String get content;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get cancel;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
