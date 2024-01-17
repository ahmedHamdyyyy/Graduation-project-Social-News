part of 'friends_cubit.dart';

class FriendsState extends Equatable {
  final String msg;
  final ErrorType error;
  final bool isFollowing;
  final Status profileFollowersState;
  final Status profileFollowingsState;
  final Status userFollowersState;
  final Status userFollowingsState;
  final Status followUserState;
  final Status unfollowUserState;
  final List<FriendModel> profileFollowers;
  final List<FriendModel> profileFollowings;
  final List<FriendModel> userFollowers;
  final List<FriendModel> userFollowings;

  const FriendsState({
    this.msg = '',
    this.isFollowing = false,
    this.error = ErrorType.non,
    this.profileFollowersState = Status.initial,
    this.profileFollowingsState = Status.initial,
    this.userFollowersState = Status.initial,
    this.userFollowingsState = Status.initial,
    this.followUserState = Status.initial,
    this.unfollowUserState = Status.initial,
    this.profileFollowers = const [],
    this.profileFollowings = const [],
    this.userFollowers = const [],
    this.userFollowings = const [],
  });

  FriendsState copyWith({
    String? msg,
    bool? isFollowing,
    ErrorType? error,
    Status? profileFollowersState,
    Status? profileFollowingsState,
    Status? userFollowersState,
    Status? userFollowingsState,
    Status? followUserState,
    Status? unfollowUserState,
    List<FriendModel>? profileFollowers,
    List<FriendModel>? profileFollowings,
    List<FriendModel>? userFollowers,
    List<FriendModel>? userFollowings,
  }) =>
      FriendsState(
        msg: msg ?? this.msg,
        isFollowing: isFollowing ?? this.isFollowing,
        error: error ?? this.error,
        profileFollowersState:
            profileFollowersState ?? this.profileFollowersState,
        profileFollowingsState:
            profileFollowingsState ?? this.profileFollowingsState,
        userFollowersState: userFollowersState ?? this.userFollowersState,
        userFollowingsState: userFollowingsState ?? this.userFollowingsState,
        followUserState: followUserState ?? this.followUserState,
        unfollowUserState: unfollowUserState ?? this.unfollowUserState,
        profileFollowers: profileFollowers ?? this.profileFollowers,
        profileFollowings: profileFollowings ?? this.profileFollowings,
        userFollowers: userFollowers ?? this.userFollowers,
        userFollowings: userFollowings ?? this.userFollowings,
      );

  @override
  List<Object> get props => [
        msg,
        error,
        isFollowing,
        profileFollowersState,
        profileFollowingsState,
        userFollowersState,
        userFollowingsState,
        followUserState,
        unfollowUserState,
        profileFollowers,
        profileFollowings,
        userFollowers,
        userFollowings,
      ];
}
