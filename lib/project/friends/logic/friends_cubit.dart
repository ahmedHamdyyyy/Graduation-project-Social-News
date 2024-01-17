import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/constants/app_constants/constants.dart';
import '../../../models/friend/friend_model.dart';
import '../../../models/response/response_model.dart';
import '../data/friends_repository.dart';
part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit() : super(const FriendsState());
  final _repository = FriendsRepository();
  ResponseModel _response = const ResponseModel();

  void setProfileFollowers(String id) async {
    if (state.profileFollowersState != Status.initial) return;
    emit(state.copyWith(profileFollowersState: Status.loading));
    _response = await _repository.getFollowers(id);
    emit(state.copyWith(
      profileFollowersState: _response.state,
      error: _response.error,
      profileFollowers: _response.data,
      msg: _response.msg,
    ));
  }

  void setProfileFollowings(String id) async {
    if (state.profileFollowingsState != Status.initial) return;
    emit(state.copyWith(profileFollowingsState: Status.loading));
    _response = await _repository.getFollowings(id);
    emit(state.copyWith(
      profileFollowingsState: _response.state,
      error: _response.error,
      profileFollowings: _response.data,
      msg: _response.msg,
    ));
  }

  void setUserFollowers(String id) async {
    emit(state.copyWith(userFollowersState: Status.loading));
    _response = await _repository.getFollowers(id);
    emit(state.copyWith(
      userFollowersState: _response.state,
      isFollowing: _response.data,
      error: _response.error,
      userFollowers: _response.data,
      msg: _response.msg,
    ));
  }

  void setUserFollowings(String id) async {
    emit(state.copyWith(userFollowingsState: Status.loading));
    _response = await _repository.getFollowings(id);
    emit(state.copyWith(
      userFollowingsState: _response.state,
      error: _response.error,
      userFollowings: _response.data,
      msg: _response.msg,
    ));
  }

  void followUser(String profileId, String id) async {
    emit(state.copyWith(followUserState: Status.loading, isFollowing: true));
    _response = await _repository.follow(profileId, id, state.isFollowing);
    emit(state.copyWith(
      followUserState: _response.state,
      error: _response.error,
      msg: _response.msg,
    ));
  }

  void get init => emit(state.copyWith(
        followUserState: Status.initial,
        profileFollowersState: Status.initial,
        profileFollowingsState: Status.initial,
        unfollowUserState: Status.initial,
        userFollowersState: Status.initial,
        userFollowingsState: Status.initial,
      ));

  void refreshProfileFriends(String id) {
    emit(state.copyWith(
      profileFollowersState: Status.initial,
      profileFollowingsState: Status.initial,
    ));
    setProfileFollowers(id);
    setProfileFollowings(id);
  }

  void setFollow(bool isFollowing) =>
      emit(state.copyWith(isFollowing: isFollowing));
}
