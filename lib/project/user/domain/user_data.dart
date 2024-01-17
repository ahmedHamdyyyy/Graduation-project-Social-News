import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../config/constants/api_constants/api_constants.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../core/services/api/api_services.dart';
import '../../../core/services/cache/cache_services.dart';
import '../../../models/response/response_model.dart';
import '../../../models/user/user_model.dart';

class UserData {
  final _cache = CacheServices();
  final _api = ApiServices.dio;
  final _user = 'user';
  late Response _response;

  UserModel get getMyData => UserModel.fromJson(_cache.getString(_user)!);
  Future<bool> get removeUser async => await _cache.remove(_user);

  Future<bool> storeMyData(UserModel user) =>
      _cache.setString(_user, user.toJson());

  Future<ResponseModel> getUserData(String id) async {
    _response = await _api.get(getUserEP(id));
    return ResponseModel(
      state:
          (_response.data['success'] as bool) ? Status.success : Status.failure,
      msg: _response.data['msg'] as String,
      statusCode: _response.statusCode,
      data: UserModel.fromMap(_response.data['data']),
    );
  }

  Future<ResponseModel> authenticatePassword(
    String email,
    String password,
  ) async {
    _response = await _api.post(
      loginEP,
      data: {'email': email, 'password': password},
    );
    if (kDebugMode) print(_response.data);
    return ResponseModel(
      state:
          (_response.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: _response.statusCode!,
      msg: _response.data['msg'],
      data: _response.data['success'],
    );
  }

  Future<ResponseModel> updateUserData(UserModel user) async {
    _response = await _api.put(updateUserEP(user.id), data: user.toMap());

    return ResponseModel(
      state:
          (_response.data['success'] as bool) ? Status.success : Status.failure,
      msg: _response.data['msg'] as String,
      statusCode: _response.statusCode,
      data: (_response.data['success'] as bool) ? user : null,
    );
  }

  Future<ResponseModel> updatePassword(String password, String userId) async {
    _response = await _api.post(
      updatePasswordEP,
      data: {'user_id': userId, 'password': password},
    );
    return ResponseModel(
      state:
          (_response.data['success'] as bool) ? Status.success : Status.failure,
      msg: _response.data['msg'] as String,
      statusCode: _response.statusCode,
    );
  }

  Future<ResponseModel> deleteUserData(String id) async {
    _response = await _api.delete(deleteUserEP(id), data: {'userId': id});
    return ResponseModel(
      state:
          (_response.data['success'] as bool) ? Status.success : Status.failure,
      msg: _response.data['msg'] as String,
      statusCode: _response.statusCode,
    );
  }
}
