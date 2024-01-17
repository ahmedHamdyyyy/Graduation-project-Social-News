import 'app_localizations.dart';

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get localStorageConnectionError => '.خطا بالاتصال بالذاكرة الداخلية';

  @override
  String get networkConnectionError => 'لا يوجد اتصال بالانترنت.';

  @override
  String get server404Error => 'خطا في الاتصال بالسيرفر (404)';

  @override
  String get server400Error => 'خطا في الاتصال بالسيرفر (400)';

  @override
  String get server401Error => 'خطا في الاتصال بالسيرفر (401)';

  @override
  String get server403Error => 'خطا في الاتصال بالسيرفر (403)';

  @override
  String get server500Error => 'خطا في الاتصال بالسيرفر (500)';

  @override
  String get unKnownError => 'خطا غير متوقع';

  @override
  String get userError => 'استخدام خاطئ للتطبيق';

  @override
  String get phoneUsedBefore => 'رقم الهاتف مستخدم بالفعل';

  @override
  String get emailUsedBefore => 'البريد الالكتروني مستخدم بالفعل';

  @override
  String get profileSetting => 'اعداد الملف الشخصي';

  @override
  String get about => 'عن التطبيق';

  @override
  String get theme => 'شكل التطبيق';

  @override
  String get language => 'اللغة';

  @override
  String get logout => 'تسجيل خروج';

  @override
  String get search => 'بحث';

  @override
  String get user => 'مستخدم';

  @override
  String get content => 'محتوي';

  @override
  String get confirm => 'تاكيد';

  @override
  String get cancel => 'الغاء';
}
