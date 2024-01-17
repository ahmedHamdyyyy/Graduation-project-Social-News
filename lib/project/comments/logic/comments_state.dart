part of 'comments_cubit.dart';

class CommentsState extends Equatable {
  final String msg;
  final String postId;
  final String image;
  final ErrorType error;
  final List<CommentModel> comments;
  final Status getCommentsState;
  final Status addCommentState;
  final Status deleteCommentState;
  final Status reactCommentState;

  const CommentsState({
    this.msg = '',
    this.postId = '',
    this.image = '',
    this.error = ErrorType.non,
    this.comments = const [],
    this.getCommentsState = Status.initial,
    this.addCommentState = Status.initial,
    this.deleteCommentState = Status.initial,
    this.reactCommentState = Status.initial,
  });
  CommentsState copyWith({
    String? msg,
    String? postId,
    String? image,
    ErrorType? error,
    List<CommentModel>? comments,
    Status? getCommentsState,
    Status? addCommentState,
    Status? deleteCommentState,
    Status? reactCommentState,
  }) =>
      CommentsState(
        msg: msg ?? this.msg,
        image: image ?? this.image,
        postId: postId ?? this.postId,
        error: error ?? this.error,
        comments: comments ?? this.comments,
        getCommentsState: getCommentsState ?? this.getCommentsState,
        addCommentState: addCommentState ?? this.addCommentState,
        deleteCommentState: deleteCommentState ?? this.deleteCommentState,
        reactCommentState: reactCommentState ?? this.reactCommentState,
      );

  @override
  List<Object> get props => [
        msg,
        image,
        postId,
        error,
        comments,
        getCommentsState,
        addCommentState,
        deleteCommentState,
        reactCommentState,
      ];
}
