import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../models/friend/friend_model.dart';

class Friend extends StatelessWidget {
  const Friend({super.key, required this.friend});
  final FriendModel friend;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 3, left: 5, right: 5),
      height: 150,
      width: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: friend.image == ''
                ? Image.asset(
                    personImage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  )
                : Image.memory(
                    base64Decode(friend.image),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
          ),
          Text(
            friend.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            textWidthBasis: TextWidthBasis.longestLine,
          ),
        ],
      ),
    );
  }
}
