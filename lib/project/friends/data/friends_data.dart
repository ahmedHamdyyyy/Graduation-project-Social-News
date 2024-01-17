import 'package:flutter/foundation.dart';
import '../../../config/constants/api_constants/api_constants.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../core/services/api/api_services.dart';
import '../../../models/friend/friend_model.dart';
import '../../../models/response/response_model.dart';
import '../../../models/user/user_model.dart';

class FriendsData {
  final _dio = ApiServices.dio;

  Future<ResponseModel> getFollowers(String id) async {
    final response = await _dio.get(getFollowersEP(id));
    if (kDebugMode) print(response.data);
    return ResponseModel(
      msg: response.data['msg'],
      statusCode: response.statusCode,
      state:
          (response.data['success'] as bool) ? Status.success : Status.failure,
      data: (response.data['data'] as List)
          .map((friend) => FriendModel.fromMap(friend))
          .toList(),
    );
  }

  Future<ResponseModel> getFollowings(String id) async {
    final response = await _dio.get(getFollowingsEP(id));
    if (kDebugMode) print(response.data);
    return ResponseModel(
      msg: response.data['msg'],
      statusCode: response.statusCode,
      state:
          (response.data['success'] as bool) ? Status.success : Status.failure,
      data: (response.data['data'] as List)
          .map((friend) => FriendModel.fromMap(friend))
          .toList(),
    );
  }

  Future<ResponseModel> follow(String profileId, String id) async {
    final response =
        await _dio.put(followUserEP(id), data: {'userId': profileId});
    if (kDebugMode) print(response.data['data']);
    return ResponseModel(
      msg: response.data['msg'],
      statusCode: response.statusCode,
      state:
          (response.data['success'] as bool) ? Status.success : Status.failure,
      data: UserModel.fromMap(response.data['data']),
    );
  }

  Future<ResponseModel> unfollow(String profileId, String id) async {
    final response =
        await _dio.put(unfollowUserEP(id), data: {'userId': profileId});
    if (kDebugMode) print(response.data['data']);
    return ResponseModel(
      msg: response.data['msg'],
      statusCode: response.statusCode,
      state:
          (response.data['success'] as bool) ? Status.success : Status.failure,
      data: UserModel.fromMap(response.data['data']),
    );
  }
}
