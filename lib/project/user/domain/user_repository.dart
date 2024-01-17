import 'package:flutter/foundation.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../core/connection/network_connection.dart';
import '../../../core/error/app_errors.dart';
import '../../../models/response/response_model.dart';
import '../../../models/user/user_model.dart';
import 'user_data.dart';

class UserRepository {
  final _data = UserData();
  ResponseModel get getMyData {
    // try {
    final user = _data.getMyData;
    if (kDebugMode) print(user);
    return ResponseModel(data: user, state: Status.success);
    // } catch (e) {
    //   if (kDebugMode) print(e);
    //   return AppErrors.cacheError;
    // }
  }

  Future<ResponseModel> getUserData(String id) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      return await _data.getUserData(id);
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> authenticatePassword(
    String email,
    String password,
  ) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      return await _data.authenticatePassword(email, password);
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> updateUserData(UserModel user) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      final response = await _data.updateUserData(user);
      if (response.state == Status.success) await _data.storeMyData(user);
      return response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> updatePassword(String password, String userId) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      return await _data.updatePassword(password, userId);
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> deleteUserData(String id) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      final response = await _data.deleteUserData(id);
      if (response.state == Status.success) await _data.removeUser;
      return response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  void setMyData(UserModel user) => _data.storeMyData(user);
}
