import 'package:flutter/foundation.dart';
import '../../../config/constants/api_constants/api_constants.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../core/services/api/api_services.dart';
import '../../../core/services/cache/cache_services.dart';
import '../../../models/map/map_point_model.dart';
import '../../../models/response/response_model.dart';
import '../../../models/search/search_model.dart';

class GlobalData {
  final _cache = CacheServices();
  final _api = ApiServices.dio;
  final _hTheme = 'current_theme';
  final _hLang = 'current_lang';
  final _user = 'user';

  Future<ResponseModel> search(String value, bool isUser) async {
    final result = await _api.post(
      isUser ? searchUserEP : searchPostEP,
      data: {'search': value},
    );
    if (kDebugMode) print(result.data);
    return ResponseModel(
      msg: result.data['msg'],
      statusCode: result.statusCode,
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      data: (result.data['success'] as bool)
          ? (result.data['data'] as List)
              .map((e) =>
                  isUser ? SearchModel.fromUser(e) : SearchModel.fromPost(e))
              .toList()
          : null,
    );
  }

  Future<ResponseModel> get getMapPoints async {
    final result = await _api.get(getMapPointsEP);
    if (kDebugMode) print(result.data);
    return ResponseModel(
      msg: result.data['msg'],
      statusCode: result.statusCode,
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      data: (result.data['success'] as bool)
          ? (result.data['data'] as List)
              .map((e) => MapPointModel.fromMap(e))
              .toList()
          : null,
    );
  }

  bool get isLoggedIn => _cache.checkKey(_user);
  bool get isThemeExist => _cache.checkKey(_hTheme);
  bool get isLangExist => _cache.checkKey(_hLang);
  int? get getCurrentTheme => _cache.getInt(_hTheme);
  String? get getCurrentLang => _cache.getString(_hLang);
  Future<bool> setTheme(int value) => _cache.setInt(_hTheme, value);
  Future<bool> setLang(String value) => _cache.setString(_hTheme, value);
}
