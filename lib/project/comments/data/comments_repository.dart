import 'package:flutter/foundation.dart';

import '../../../core/connection/network_connection.dart';
import '../../../core/error/app_errors.dart';
import '../../../models/comment/comment_model.dart';
import '../../../models/response/response_model.dart';
import 'comments_data.dart';

class CommentsRepository {
  final _data = CommentsData();
  ResponseModel _response = const ResponseModel();

  Future<ResponseModel> getPostComments(String id, String profileId) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    // try {
    _response = await _data.getPostComments(id, profileId);
    if (_response.statusCode != 200) {
      _response = AppErrors.serverError(_response.statusCode!);
    }
    // } catch (e) {
    //   if (kDebugMode) print(e);
    //   _response = AppErrors.serverError(404);
    // }
    return _response;
  }

  Future<ResponseModel> addComment(CommentModel comment) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.addComment(comment);
    } catch (e) {
      if (kDebugMode) print(e);
      _response = AppErrors.serverError(404);
    }
    return _response;
  }

  Future<ResponseModel> reactComment(String profileId, String commentId) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.reactComment(commentId, profileId);
      if (_response.statusCode != 200) {
        _response = AppErrors.serverError(_response.statusCode!);
      }
    } catch (e) {
      if (kDebugMode) print(e);
      _response = AppErrors.serverError(404);
    }
    return _response;
  }

  Future<ResponseModel> deleteComment(String commentId) async {
    if (!await NetworkConnection.isConnected) return AppErrors.networkError;
    try {
      _response = await _data.deleteComment(commentId);
      if (_response.statusCode != 200) {
        _response = AppErrors.serverError(_response.statusCode!);
      }
    } catch (e) {
      if (kDebugMode) print(e);
      _response = AppErrors.serverError(404);
    }
    return _response;
  }
}
