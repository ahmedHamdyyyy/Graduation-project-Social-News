import 'package:flutter/foundation.dart';
import '../../../config/constants/api_constants/api_constants.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../core/services/api/api_services.dart';
import '../../../models/post/post_converter.dart';
import '../../../models/post/post_generated_model.dart';
import '../../../models/post/post_model.dart';
import '../../../models/response/response_model.dart';

class PostsData {
  final _api = ApiServices.dio;

  Future<ResponseModel> get getGlobalPosts async {
    final result = await _api.get(getGlobalPostsEP);
    if (kDebugMode) print(result.data);
    return ResponseModel(
      msg: result.data['msg'],
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      data: (result.data['success'] as bool)
          ? (result.data['data'] as List)
              .map((e) => PostModel.fromConverter(PostConverter.fromMap(e)))
              .toList()
          : null,
    );
  }

  Future<ResponseModel> getPost(String id) async {
    final result = await _api.get(getPostEP(id));
    if (kDebugMode) print(result.data);
    return ResponseModel(
      msg: result.data['msg'],
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      data: (result.data['success'] as bool)
          ? PostModel.fromConverter(PostConverter.fromMap(result.data['data']))
          : null,
    );
  }

  Future<ResponseModel> getMapPointPosts(List<String> ids) async {
    final result = await _api.post(getMapPointPostsEP, data: {'postIds': ids});
    if (kDebugMode) print(result.data);
    return ResponseModel(
      msg: result.data['msg'],
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      data: (result.data['success'] as bool)
          ? (result.data['data']['posts'] as List)
              .map((e) => PostModel.fromConverter(PostConverter.fromMap(e)))
              .toList()
          : null,
    );
  }

  Future<ResponseModel> getLocalPosts(
    double lat,
    double long,
    double distance,
  ) async {
    final result = await ApiServices.dio.get(
      getLocalPostsEP,
      queryParameters: {'lat': lat, 'long': long, 'distance': distance},
    );
    if (kDebugMode) print(result.data);
    return ResponseModel(
      msg: result.data['msg'],
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      data: (result.data['success'] as bool)
          ? (result.data['data'] as List)
              .map((e) => PostModel.fromConverter(PostConverter.fromMap(e)))
              .toList()
          : null,
    );
  }

  Future<ResponseModel> get getSummaryPosts async {
    final result = await _api.get(getGeneratedPostsEP); //summary
    if (kDebugMode) print(result.data);
    return ResponseModel(
      msg: result.data['msg'],
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      data: (result.data['success'] as bool)
          ? (result.data['data'] as List)
              .map((post) => PostGenerated.fromMap(post))
              .toList()
          : null,
    );
  }

  Future<ResponseModel> getUserPosts(String id) async {
    final result = await _api.get(getUserPostEP(id));
    if (kDebugMode) print(result.data);
    return ResponseModel(
      msg: result.data['msg'],
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      data: (result.data['success'] as bool)
          ? (result.data['data'] as List)
              .map((e) => PostModel.fromConverter(PostConverter.fromMap(e)))
              .toList()
          : null,
    );
  }

  Future<ResponseModel> getGeneratedPostPosts(String id) async {
    final result = await _api.get(getGeneratedPostPostsEP(id));
    if (kDebugMode) print(result.data);
    return ResponseModel(
      msg: result.data['msg'],
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      data: (result.data['success'] as bool)
          ? (result.data['data']['posts'] as List)
              .map((e) => PostModel.fromConverter(PostConverter.fromMap(e)))
              .toList()
          : null,
    );
  }

  Future<ResponseModel> addPost(PostModel post) async {
    final result = await _api.post(
      addPostEP,
      data: post.toMap(),
    );
    if (kDebugMode) print(result.data);
    return ResponseModel(
      msg: result.data['msg'],
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      data: (result.data['success'] as bool)
          ? PostModel.fromConverter(PostConverter.fromMap(result.data['data']))
          : null,
    );
  }

  Future<ResponseModel> updatePost(PostModel post) async {
    final result = await _api.put(
      editPostEP(post.id),
      data: post.toMap(),
    );
    if (kDebugMode) print(result.data);
    return ResponseModel(
      msg: result.data['msg'],
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      data: (result.data['success'] as bool)
          ? PostModel.fromConverter(PostConverter.fromMap(result.data['data']))
          : null,
    );
  }

  Future<ResponseModel> deletePost(String postId) async {
    final result = await _api.delete(
      deletePostEP(postId),
      data: {'userId': profileData.id},
    );
    if (kDebugMode) print(result.data);
    return ResponseModel(
      msg: result.data['msg'],
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
    );
  }

  Future<ResponseModel> reactPost(String postId) async {
    final result = await _api.put(
      reactPostEP(postId),
      data: {'userId': profileData.id},
    );
    if (kDebugMode) print(result.data);
    return ResponseModel(
      msg: result.data['msg'],
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      data: PostModel.fromConverter(PostConverter.fromMap(result.data['data'])),
    );
  }
}
