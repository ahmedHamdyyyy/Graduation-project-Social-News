import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get localStorageConnectionError => 'local storage connection error.';

  @override
  String get networkConnectionError => 'Network connection error check the internet connection.';

  @override
  String get server404Error => 'Server error 404 (server not found).';

  @override
  String get server400Error => 'Server error 400 (Bad Request).';

  @override
  String get server401Error => 'Server error 401 (Authentication credential).';

  @override
  String get server403Error => 'Server error 403 (have no permission).';

  @override
  String get server500Error => 'Server error 500 (Internal Server Error).';

  @override
  String get unKnownError => 'unKnown error please try again later.';

  @override
  String get userError => 'Bad Usage Of The App.';

  @override
  String get phoneUsedBefore => 'this phone number is currently used';

  @override
  String get emailUsedBefore => 'this email is currently used';

  @override
  String get profileSetting => 'profile setting';

  @override
  String get about => 'about';

  @override
  String get theme => 'theme';

  @override
  String get language => 'language';

  @override
  String get logout => 'logout';

  @override
  String get search => 'search';

  @override
  String get user => 'user';

  @override
  String get content => 'content';

  @override
  String get confirm => 'confirm';

  @override
  String get cancel => 'cancel';
}
