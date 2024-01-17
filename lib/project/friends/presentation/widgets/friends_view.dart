import 'package:flutter/material.dart';
import '../../../../models/friend/friend_model.dart';
import 'friend.dart';

class FriendsWidget extends StatelessWidget {
  const FriendsWidget({super.key, required this.friends});
  final List<FriendModel> friends;
  @override
  Widget build(BuildContext context) {
    return friends.isNotEmpty
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: friends.length,
            itemBuilder: (_, index) => Friend(friend: friends[index]),
          )
        : const Center(child: Text('No Friends Add'));
  }
}
