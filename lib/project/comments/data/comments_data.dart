import 'package:flutter/foundation.dart';
import '../../../config/constants/api_constants/api_constants.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../core/services/api/api_services.dart';
import '../../../models/comment/comment_converter_model.dart';
import '../../../models/comment/comment_model.dart';
import '../../../models/response/response_model.dart';

class CommentsData {
  final _dio = ApiServices.dio;

  Future<ResponseModel> getPostComments(String id, String profileId) async {
    final result = await _dio.get(getPostCommentsEP(id));
    if (kDebugMode) print('get comments ${result.data['data']}');
    return ResponseModel(
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      msg: result.data['msg'],
      data: (result.data['data'] as List)
          .map((comment) =>
              CommentModel.fromConverter(CommentConverter.fromMap(comment)))
          .toList(),
    );
  }

  Future<ResponseModel> addComment(CommentModel comment) async {
    final result = await _dio.post(addCommentEP, data: comment.toMap());
    if (kDebugMode) print(result.data['data']);
    return ResponseModel(
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      msg: result.data['msg'],
      data: CommentModel.fromConverter(
          CommentConverter.fromMap(result.data['data'])),
    );
  }

  Future<ResponseModel> deleteComment(String id) async {
    final result = await _dio.delete(deleteCommentEP(id));
    if (kDebugMode) print(result.data['data']);
    return ResponseModel(
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      msg: result.data['msg'],
    );
  }

  Future<ResponseModel> reactComment(String commentId, String profileId) async {
    final result = await _dio.put(
      reactCommentEP(commentId),
      data: {'userId': profileId},
    );
    if (kDebugMode) print(result.data);
    return ResponseModel(
      state: (result.data['success'] as bool) ? Status.success : Status.failure,
      statusCode: result.statusCode,
      msg: result.data['msg'],
    );
  }
}
