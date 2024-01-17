import 'package:flutter/foundation.dart';
import '../../../core/connection/network_connection.dart';
import '../../../core/error/app_errors.dart';
import '../../../models/post/post_model.dart';
import '../../../models/response/response_model.dart';
import 'posts_data.dart';

class PostsRepository {
  final _data = PostsData();
  ResponseModel _response = const ResponseModel();

  Future<ResponseModel> get getGlobalPosts async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    // try {
    _response = await _data.getGlobalPosts;
    if (_response.statusCode != 200) {
      return AppErrors.serverError(_response.statusCode!);
    }
    return _response;
    // } catch (e) {
    //   if (kDebugMode) print(e);
    //   return AppErrors.serverError(404);
    // }
  }

  Future<ResponseModel> getPost(String id) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.getPost(id);
      if (_response.statusCode != 200) {
        return AppErrors.serverError(_response.statusCode!);
      }
      return _response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> getMapPointPosts(List<String> ids) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.getMapPointPosts(ids);
      if (_response.statusCode != 200) {
        return AppErrors.serverError(_response.statusCode!);
      }
      return _response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> getUserPosts(String id) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.getUserPosts(id);
      if (_response.statusCode != 200) {
        return AppErrors.serverError(_response.statusCode!);
      }
      return _response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> getGeneratedPostPosts(String id) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.getGeneratedPostPosts(id);
      if (_response.statusCode != 200) {
        return AppErrors.serverError(_response.statusCode!);
      }
      return _response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> getLocalPosts(
    double lat,
    double long,
    double distance,
  ) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.getLocalPosts(lat, long, distance);
      if (_response.statusCode != 200) {
        return AppErrors.serverError(_response.statusCode!);
      }
      return _response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> get getSummaryPosts async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.getSummaryPosts;
      if (_response.statusCode != 200) {
        return AppErrors.serverError(_response.statusCode!);
      }
      return _response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> addPost(PostModel post) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.addPost(post);
      if (_response.statusCode != 200) {
        return AppErrors.serverError(_response.statusCode!);
      }
      return _response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> updatePost(PostModel post) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.updatePost(post);
      if (_response.statusCode != 200) {
        return AppErrors.serverError(_response.statusCode!);
      }
      return _response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> deletePost(String postId) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.deletePost(postId);
      if (_response.statusCode != 200) {
        return AppErrors.serverError(_response.statusCode!);
      }
      return _response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }

  Future<ResponseModel> reactPost(String postId) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.reactPost(postId);
      if (_response.statusCode != 200) {
        return AppErrors.serverError(_response.statusCode!);
      }
      return _response;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppErrors.serverError(404);
    }
  }
}
