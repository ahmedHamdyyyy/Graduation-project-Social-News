import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../config/constants/api_constants/api_constants.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../core/services/api/api_services.dart';
import '../../../core/services/cache/cache_services.dart';
import '../../../models/response/response_model.dart';
import '../../../models/user/user_model.dart';

class AuthData {
  final _api = ApiServices.dio;
  final _cache = CacheServices.shared;

  Future<ResponseModel> login(String mail, String password) async {
    const secureStorage = FlutterSecureStorage();
    final apiResponse = await _api.post(
      loginEP,
      data: {'email': mail, 'password': password},
    );
    if (kDebugMode) print(apiResponse.data);
    secureStorage.write(
        key: 'token', value: apiResponse.data['data']['accessToken']);
    return ResponseModel(
      state: (apiResponse.data['success'] as bool)
          ? Status.success
          : Status.failure,
      statusCode: apiResponse.statusCode!,
      msg: apiResponse.data['msg'],
      data: (apiResponse.data['success'] as bool)
          ? UserModel.fromMap(apiResponse.data['data'])
          : null,
    );
  }

  Future<ResponseModel> get logout async {
    final apiResponse = await _api.delete(
      logoutEP,
      data: {'user_id': profileData.id},
    );
    if (kDebugMode) print(apiResponse.data);
    return ResponseModel(
      statusCode: apiResponse.statusCode!,
      msg: apiResponse.data['msg'],
      state: (apiResponse.data['success'] as bool)
          ? Status.success
          : Status.failure,
    );
  }

  Future<ResponseModel> register(UserModel user, String password) async {
    final apiResponse = await _api.post(
      registerEP,
      data: user.register(password),
    );
    if (kDebugMode) print(apiResponse.data);
    return ResponseModel(
      statusCode: apiResponse.statusCode!,
      msg: apiResponse.data['msg'],
      state: (apiResponse.data['success'] as bool)
          ? Status.success
          : Status.failure,
    );
  }

  Future<ResponseModel> confirmCode(String email, String code) async {
    final apiResponse = await _api.post(
      confirmCodeEP,
      data: {
        'email': email,
        'confirmationCode': code,
      },
    );
    if (kDebugMode) print(apiResponse.data);
    return ResponseModel(
      statusCode: apiResponse.statusCode!,
      msg: apiResponse.data['msg'],
      state: (apiResponse.data['success'] as bool)
          ? Status.success
          : Status.failure,
    );
  }

  Future<ResponseModel> forgetPassword(String email) async {
    final apiResponse = await _api.post(
      forgetPasswordEP,
      data: {'email': email},
    );
    if (kDebugMode) print(apiResponse.data);
    return ResponseModel(
      statusCode: apiResponse.statusCode!,
      msg: apiResponse.data['msg'],
      state: (apiResponse.data['success'] as bool)
          ? Status.success
          : Status.failure,
    );
  }

  Future<ResponseModel> confirmEmail(String code) async {
    final apiResponse = await _api.post(
      confirmEmailEP,
      data: {'resetCode': code},
    );
    if (kDebugMode) print(apiResponse.data);
    return ResponseModel(
      statusCode: apiResponse.statusCode!,
      msg: apiResponse.data['msg'],
      state: (apiResponse.data['success'] as bool)
          ? Status.success
          : Status.failure,
    );
  }

  Future<ResponseModel> resetPassword(String password, String email) async {
    final apiResponse = await _api.put(
      resetPasswordEP,
      data: {'newPassword': password, 'email': email},
    );
    if (kDebugMode) print(apiResponse.data);
    return ResponseModel(
      statusCode: apiResponse.statusCode!,
      msg: apiResponse.data['msg'],
      state: (apiResponse.data['success'] as bool)
          ? Status.success
          : Status.failure,
    );
  }

  Future<bool> storeUser(UserModel user) =>
      _cache.setString('user', user.toJson());

  Future<bool> get removeUser async => await _cache.remove('user');
}
