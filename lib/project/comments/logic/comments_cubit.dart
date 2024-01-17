import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/constants/app_constants/constants.dart';
import '../../../models/comment/comment_model.dart';
import '../../../models/response/response_model.dart';
import '../data/comments_repository.dart';
part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(const CommentsState());
  final _repository = CommentsRepository();
  ResponseModel result = const ResponseModel();
  final profileId = profileData.id;

  void getPostComments(String postId) async {
    emit(state.copyWith(getCommentsState: Status.loading));
    result = await _repository.getPostComments(postId, profileId);
    emit(state.copyWith(
      msg: result.msg,
      comments: result.data,
      postId: postId,
      error: result.error,
      getCommentsState: result.state,
    ));
  }

  void addComment(CommentModel comment) async {
    emit(state.copyWith(addCommentState: Status.loading));
    result = await _repository.addComment(comment);
    emit(state.copyWith(
      msg: result.msg,
      error: result.error,
      addCommentState: result.state,
      comments: result.state != Status.success
          ? state.comments
          : List.from(state.comments)
        ..add(result.data),
    ));
  }

  void reactComment(String profileId, String commentId) async {
    emit(state.copyWith(reactCommentState: Status.loading));
    result = await _repository.reactComment(profileId, commentId);
    updateComments(commentId);
    emit(state.copyWith(
      msg: result.msg,
      error: result.error,
      reactCommentState: result.state,
    ));
  }

  void updateComments(String commentId) {
    if (result.state == Status.success) {
      CommentModel comment =
          state.comments.where((element) => element.id == commentId).first;
      comment.update(
        likes: comment.isLiked ? comment.likes - 1 : comment.likes + 1,
        isLiked: !comment.isLiked,
      );
      final index =
          state.comments.indexWhere((element) => element.id == commentId);
      final List<CommentModel> comments = List.from(state.comments)
        ..[index] = comment;
      emit(state.copyWith(comments: comments));
    }
  }

  void deleteComment(String commentId) async {
    emit(state.copyWith(deleteCommentState: Status.loading));
    result = await _repository.deleteComment(commentId);
    emit(state.copyWith(
      msg: result.msg,
      error: result.error,
      deleteCommentState: result.state,
    ));
  }

  void get initCreate => emit(state.copyWith(addCommentState: Status.initial));
  void get initDelete =>
      emit(state.copyWith(deleteCommentState: Status.initial));
  String get getPostId => state.postId;
}
