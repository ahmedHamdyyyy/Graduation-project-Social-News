import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../models/post/post_generated_model.dart';
import '../../../models/post/post_model.dart';
import '../../../models/response/response_model.dart';
import '../domain/posts_repository.dart';
part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(const PostsState());
  final PostsRepository _repository = PostsRepository();
  ResponseModel _response = const ResponseModel();

  void get setGlobalPosts async {
    if (state.globalPostsState != Status.initial) return;
    emit(state.copyWith(globalPostsState: Status.loading));
    _response = await _repository.getGlobalPosts;
    emit(state.copyWith(
      globalPosts: _response.data,
      globalPostsState: _response.state,
      msg: _response.msg,
      error: _response.error,
    ));
  }

  void getPost(String id) async {
    emit(state.copyWith(
      getPostState: Status.loading,
      searchPost: PostModel.non,
    ));
    _response = await _repository.getPost(id);
    emit(state.copyWith(
      getPostState: _response.state,
      error: _response.error,
      msg: _response.msg,
      searchPost: _response.state == Status.success ? _response.data : state.searchPost,
    ));
  }

  void getMapPointPosts(List<String> ids) async {
    emit(state.copyWith(mapPointPostsState: Status.loading));
    _response = await _repository.getMapPointPosts(ids);
    emit(state.copyWith(
      mapPostPosts: _response.data,
      mapPointPostsState: _response.state,
      msg: _response.msg,
      error: _response.error,
    ));
  }

  void setLocalPosts(double lat, double long, double distance) async {
    if (state.localPostsState != Status.initial) return;
    emit(state.copyWith(localPostsState: Status.loading));
    _response = await _repository.getLocalPosts(lat, long, distance);
    emit(state.copyWith(
      localPosts: _response.data,
      localPostsState: _response.state,
      msg: _response.msg,
      error: _response.error,
    ));
  }

  void get setSummaryPosts async {
    if (state.summaryPostsState != Status.initial) return;
    emit(state.copyWith(summaryPostsState: Status.loading));
    _response = await _repository.getSummaryPosts;
    emit(state.copyWith(
      summaryPosts: _response.data,
      summaryPostsState: _response.state,
      msg: _response.msg,
      error: _response.error,
    ));
  }

  void setUserPosts(String id) async {
    emit(state.copyWith(userPostsState: Status.loading));
    _response = await _repository.getUserPosts(id);
    emit(state.copyWith(
      userPosts: _response.data,
      userPostsState: _response.state,
      msg: _response.msg,
      error: _response.error,
    ));
  }

  void getGeneratedPostPosts(String id) async {
    emit(state.copyWith(getGeneratedPostPostsState: Status.loading));
    _response = await _repository.getGeneratedPostPosts(id);
    emit(state.copyWith(
      getGeneratedPostPosts: _response.data,
      getGeneratedPostPostsState: _response.state,
      msg: _response.msg,
      error: _response.error,
    ));
  }

  void get setProfilePosts async {
    if (state.profilePostsState != Status.initial) return;
    emit(state.copyWith(profilePostsState: Status.loading));
    _response = await _repository.getUserPosts(profileData.id);
    emit(state.copyWith(
      profilePosts: _response.data,
      profilePostsState: _response.state,
      msg: _response.msg,
      error: _response.error,
    ));
  }

  void addPost(PostModel post, BuildContext context) async {
    emit(state.copyWith(createPostState: Status.loading));
    _response = await _repository.addPost(post);
    emit(state.copyWith(
      profilePosts: _response.state != Status.success ? state.profilePosts : List.from(state.profilePosts)
        ..add(_response.data),
      createPostState: _response.state,
      msg: _response.msg,
      error: _response.error,
    ));
  }

  void editPost(PostModel post) async {
    emit(state.copyWith(updatePostState: Status.loading));
    _response = await _repository.updatePost(post);
    final List<PostModel> profilePosts = List.from(state.profilePosts);
    if (_response.state == Status.success) {
      final index = state.profilePosts.indexWhere((element) => element.id == post.id);
      profilePosts[index] = post;
    }
    emit(state.copyWith(
      profilePosts: profilePosts,
      updatePostState: _response.state,
      msg: _response.msg,
      error: _response.error,
    ));
  }

  void deletePost(String postId) async {
    emit(state.copyWith(deletePostState: Status.loading));
    _response = await _repository.deletePost(postId);
    final List<PostModel> profilePosts = List.from(state.profilePosts);
    if (_response.state == Status.success) {
      profilePosts.removeWhere((element) => element.id == postId);
    }
    emit(state.copyWith(
      profilePosts: profilePosts,
      deletePostState: _response.state,
      msg: _response.msg,
      error: _response.error,
    ));
  }

  void reactPost(String postId) async {
    emit(state.copyWith(reactPostState: Status.loading));
    _response = await _repository.reactPost(postId);
    if (_response.state == Status.failure || _response.state == Status.error) {
      emit(state.copyWith(
        reactPostState: _response.state,
        msg: _response.msg,
        error: _response.error,
      ));
      return;
    }
    final globalIndex = state.globalPosts.indexWhere((post) => post.id == postId);
    if (globalIndex != -1) {
      emit(state.copyWith(
        globalPosts: List.from(state.globalPosts)..[globalIndex] = _response.data,
      ));
    }
    final profileIndex = state.profilePosts.indexWhere((post) => post.id == postId);
    if (profileIndex != -1) {
      emit(state.copyWith(
        profilePosts: List.from(state.profilePosts)..[profileIndex] = _response.data,
      ));
    }
    final filterIndex = state.filteredPosts.indexWhere((post) => post.id == postId);
    if (profileIndex != -1) {
      emit(state.copyWith(
        filteredPosts: List.from(state.filteredPosts)..[filterIndex] = _response.data,
      ));
    }
    final userIndex = state.userPosts.indexWhere((post) => post.id == postId);
    if (userIndex != -1) {
      emit(state.copyWith(
        userPosts: List.from(state.userPosts)..[userIndex] = _response.data,
      ));
    }
  }

  void setFilter(Filter filter) {
    List<PostModel> filtered = [];
    for (int i = 0; i <= state.globalPosts.length - 1; i++) {
      if (state.globalPosts[i].filter == filter) {
        filtered.add(state.globalPosts[i]);
      }
    }
    emit(state.copyWith(
      filter: filter,
      filteredPosts: filtered,
    ));
  }

  void get init => emit(state.copyWith(
        createPostState: Status.initial,
        deletePostState: Status.initial,
        globalPostsState: Status.initial,
        localPostsState: Status.initial,
        profilePostsState: Status.initial,
        reactPostState: Status.initial,
        summaryPostsState: Status.initial,
        updatePostState: Status.initial,
        userPostsState: Status.initial,
      ));

  void refreshUserPosts(String id) async {
    emit(state.copyWith(userPostsState: Status.initial));
    setUserPosts(id);
  }

  void get refreshProfilePosts async {
    emit(state.copyWith(profilePostsState: Status.initial));
    setProfilePosts;
  }

  void get refreshGlobalPosts async {
    emit(state.copyWith(globalPostsState: Status.initial));
    setGlobalPosts;
  }

  void refreshLocalPosts(double lat, double long, double distance) async {
    emit(state.copyWith(localPostsState: Status.initial));
    setLocalPosts(lat, long, distance);
  }

  void get refreshSummaryPosts async {
    emit(state.copyWith(summaryPostsState: Status.initial));
    setSummaryPosts;
  }

  void pickImage(String img) => emit(state.copyWith(img: img));
  void get clearPostImage => emit(state.copyWith(img: ''));
  String get getPostImage => state.img;
  void get initUpdate => emit(state.copyWith(updatePostState: Status.initial));
  void get initDelete => emit(state.copyWith(deletePostState: Status.initial));
  void get initCreate => emit(state.copyWith(createPostState: Status.initial, img: ''));
}
