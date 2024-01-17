import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../core/connection/network_connection.dart';
import '../../../core/error/app_errors.dart';
import '../../../models/response/response_model.dart';
import 'global_data.dart';

class GlobalRepository {
  final _data = GlobalData();

  ResponseModel get isLoggedIn {
    try {
      return ResponseModel(state: Status.success, data: _data.isLoggedIn);
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.cacheError;
    }
  }

  ResponseModel get getCurrentLang {
    // try {
    return ResponseModel(
      state: Status.success,
      data: _data.isLangExist ? _data.getCurrentLang! : 'en',
    );
    // } catch (e) {
    //   if (kDebugMode) print(e);
    //   return AppErrors.cacheError;
    // }
  }

  ResponseModel get getCurrentTheme {
    // try {
    return ResponseModel(
      state: Status.success,
      data: _data.isThemeExist ? _data.getCurrentTheme! : 0,
    );
    // } catch (e) {
    //   if (kDebugMode) print(e);
    //   return AppErrors.cacheError;
    // }
  }

  Future<ResponseModel> setTheme(int theme) async {
    try {
      final isChanged = await _data.setTheme(theme);
      return ResponseModel(
        data: theme,
        state: isChanged ? Status.success : Status.error,
        error: isChanged ? ErrorType.non : ErrorType.cache,
      );
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.cacheError;
    }
  }

  Future<ResponseModel> setLang(String value) async {
    try {
      final isChanged = await _data.setLang(value);
      return ResponseModel(
        data: value,
        state: isChanged ? Status.success : Status.error,
        error: isChanged ? ErrorType.non : ErrorType.cache,
      );
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.cacheError;
    }
  }

  Future<ResponseModel> search(String value, bool isUser) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      final result = await _data.search(value, isUser);
      if (result.state == Status.success || result.state == Status.failure) {
        return result;
      }
      return AppErrors.serverError(result.statusCode!);
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> get getMapPoints async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      final result = await _data.getMapPoints;
      if (result.state == Status.success || result.state == Status.failure) {
        return result;
      }
      return AppErrors.serverError(result.statusCode!);
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<bool> get isNetworkConnected async =>
      await NetworkConnection.isConnected;

  bool checkConnection(ConnectivityResult connectivityResult) =>
      NetworkConnection.checkConnection(connectivityResult);

  Stream<ConnectivityResult> get connectedStream =>
      NetworkConnection.connectionStream;
}
