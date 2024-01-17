part of 'posts_cubit.dart';

class PostsState extends Equatable {
  final String msg;
  final String img;
  final ErrorType error;
  final Filter filter;
  final Status createPostState;
  final Status mapPointPostsState;
  final Status reactPostState;
  final Status updatePostState;
  final Status deletePostState;
  final Status localPostsState;
  final Status globalPostsState;
  final Status userPostsState;
  final Status profilePostsState;
  final Status summaryPostsState;
  final Status getGeneratedPostPostsState;
  final Status getPostState;
  final PostModel searchPost;
  final List<PostModel> localPosts;
  final List<PostModel> filteredPosts;
  final List<PostModel> mapPostPosts;
  final List<PostModel> globalPosts;
  final List<PostModel> userPosts;
  final List<PostModel> profilePosts;
  final List<PostModel> getGeneratedPostPosts;
  final List<PostGenerated> summaryPosts;

  const PostsState({
    this.msg = '',
    this.img = '',
    this.error = ErrorType.non,
    this.filter = Filter.non,
    this.createPostState = Status.initial,
    this.mapPointPostsState = Status.initial,
    this.reactPostState = Status.initial,
    this.updatePostState = Status.initial,
    this.deletePostState = Status.initial,
    this.localPostsState = Status.initial,
    this.summaryPostsState = Status.initial,
    this.getGeneratedPostPostsState = Status.initial,
    this.getPostState = Status.initial,
    this.searchPost = PostModel.non,
    this.globalPostsState = Status.initial,
    this.userPostsState = Status.initial,
    this.profilePostsState = Status.initial,
    this.localPosts = const [],
    this.filteredPosts = const [],
    this.mapPostPosts = const [],
    this.globalPosts = const [],
    this.userPosts = const [],
    this.profilePosts = const [],
    this.getGeneratedPostPosts = const [],
    this.summaryPosts = const [],
  });

  @override
  List<Object> get props => [
        msg,
        img,
        error,
        filter,
        reactPostState,
        createPostState,
        mapPointPostsState,
        updatePostState,
        deletePostState,
        summaryPostsState,
        getGeneratedPostPostsState,
        getPostState,
        searchPost,
        localPostsState,
        globalPostsState,
        userPostsState,
        profilePostsState,
        localPosts,
        filteredPosts,
        mapPostPosts,
        globalPosts,
        userPosts,
        profilePosts,
        getGeneratedPostPosts,
        summaryPosts,
      ];

  PostsState copyWith({
    String? msg,
    String? img,
    ErrorType? error,
    Filter? filter,
    Status? reactPostState,
    Status? createPostState,
    Status? mapPointPostsState,
    Status? updatePostState,
    Status? deletePostState,
    Status? localPostsState,
    Status? summaryPostsState,
    Status? getGeneratedPostPostsState,
    Status? getPostState,
    PostModel? searchPost,
    Status? globalPostsState,
    Status? userPostsState,
    Status? profilePostsState,
    List<PostModel>? localPosts,
    List<PostModel>? filteredPosts,
    List<PostModel>? mapPostPosts,
    List<PostModel>? globalPosts,
    List<PostModel>? userPosts,
    List<PostModel>? profilePosts,
    List<PostModel>? getGeneratedPostPosts,
    List<PostGenerated>? summaryPosts,
  }) =>
      PostsState(
        msg: msg ?? this.msg,
        img: img ?? this.img,
        error: error ?? this.error,
        filter: filter ?? this.filter,
        reactPostState: reactPostState ?? this.reactPostState,
        createPostState: createPostState ?? this.createPostState,
        mapPointPostsState: mapPointPostsState ?? this.mapPointPostsState,
        updatePostState: updatePostState ?? this.updatePostState,
        deletePostState: deletePostState ?? this.deletePostState,
        localPostsState: localPostsState ?? this.localPostsState,
        summaryPostsState: summaryPostsState ?? this.summaryPostsState,
        getGeneratedPostPostsState:
            getGeneratedPostPostsState ?? this.getGeneratedPostPostsState,
        getPostState: getPostState ?? this.getPostState,
        searchPost: searchPost ?? this.searchPost,
        globalPostsState: globalPostsState ?? this.globalPostsState,
        userPostsState: userPostsState ?? this.userPostsState,
        profilePostsState: profilePostsState ?? this.profilePostsState,
        localPosts: localPosts ?? this.localPosts,
        filteredPosts: filteredPosts ?? this.filteredPosts,
        mapPostPosts: mapPostPosts ?? this.mapPostPosts,
        globalPosts: globalPosts ?? this.globalPosts,
        userPosts: userPosts ?? this.userPosts,
        profilePosts: profilePosts ?? this.profilePosts,
        getGeneratedPostPosts:
            getGeneratedPostPosts ?? this.getGeneratedPostPosts,
        summaryPosts: summaryPosts ?? this.summaryPosts,
      );
}
