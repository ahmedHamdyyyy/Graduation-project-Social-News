import 'package:flutter/material.dart';
import 'profile_followers.dart';
import 'profile_followings.dart';
import 'user_followers.dart';
import 'user_followings.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({
    super.key,
    required this.isFollowers,
    required this.isUser,
    this.id = '',
  });
  final bool isUser;
  final bool isFollowers;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder: (_) => isFollowers
            ? isUser
                ? UserFollowers(id: id)
                : const ProfileFollowers()
            : isUser
                ? UserFollowings(id: id)
                : const ProfileFollowings(),
      ),
    );
  }
}
