import 'package:flutter/foundation.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../core/connection/network_connection.dart';
import '../../../core/error/app_errors.dart';
import '../../../models/response/response_model.dart';
import '../../../models/user/user_model.dart';
import 'auth_data.dart';

class AuthRepository {
  final _data = AuthData();
  ResponseModel _response = const ResponseModel();

  Future<ResponseModel> login(String mail, String password) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.login(mail, password);
      _data.storeUser(_response.data);
    } catch (e) {
      if (kDebugMode) print(e);
      _response = AppErrors.serverError(404);
    }
    return _response;
  }

  Future<ResponseModel> get logout async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.logout;
      _response.state == Status.success ? await _data.removeUser : null;
    } catch (e) {
      if (kDebugMode) print(e);
      _response = AppErrors.serverError(404);
    }
    return _response;
  }

  Future<ResponseModel> register(UserModel user, String password) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.register(user, password);
    } catch (e) {
      if (kDebugMode) print(e);
      _response = AppErrors.serverError(404);
    }
    return _response;
  }

  Future<ResponseModel> confirmCode(String email, String code) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.confirmCode(email, code);
    } catch (e) {
      if (kDebugMode) print(e);
      _response = AppErrors.serverError(404);
    }
    return _response;
  }

  Future<ResponseModel> forgetPassword(String email) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.forgetPassword(email);
    } catch (e) {
      if (kDebugMode) print(e);
      _response = AppErrors.serverError(404);
    }
    return _response;
  }

  Future<ResponseModel> confirmEmail(String code) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.confirmEmail(code);
    } catch (e) {
      if (kDebugMode) print(e);
      _response = AppErrors.serverError(404);
    }
    return _response;
  }

  Future<ResponseModel> resetPassword(String password, String email) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.resetPassword(password, email);
    } catch (e) {
      if (kDebugMode) print(e);
      _response = AppErrors.serverError(404);
    }
    return _response;
  }
}
