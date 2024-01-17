import 'package:flutter/foundation.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../core/connection/network_connection.dart';
import '../../../core/error/app_errors.dart';
import '../../../models/response/response_model.dart';
import 'friends_data.dart';

class FriendsRepository {
  final _data = FriendsData();
  ResponseModel _response = const ResponseModel();

  Future<ResponseModel> getFollowers(String id) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    // try {
    _response = await _data.getFollowers(id);
    if (_response.state == Status.failure) {
      _response = AppErrors.serverError(_response.statusCode!);
    }
    // } catch (e) {
    //   if (kDebugMode) print(e);
    //   _response = AppErrors.serverError(404);
    // }
    return _response;
  }

  Future<ResponseModel> getFollowings(String id) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.getFollowings(id);
      if (_response.state == Status.failure) {
        _response = AppErrors.serverError(_response.statusCode!);
      }
    } catch (e) {
      if (kDebugMode) print(e);
      _response = AppErrors.serverError(404);
    }
    return _response;
  }

  Future<ResponseModel> follow(profileId, String id, bool isFollowing) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = isFollowing
          ? await _data.unfollow(profileId, id)
          : await _data.follow(profileId, id);
      if (_response.state == Status.failure) {
        _response = AppErrors.serverError(_response.statusCode!);
      }
    } catch (e) {
      if (kDebugMode) print(e);
      _response = AppErrors.serverError(404);
    }
    return _response;
  }
}
