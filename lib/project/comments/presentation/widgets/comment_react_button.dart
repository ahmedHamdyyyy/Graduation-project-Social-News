// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../user/logic/user_cubit.dart';
import '../../logic/comments_cubit.dart';

class CommentReactButton extends StatelessWidget {
  CommentReactButton({
    super.key,
    required this.likes,
    required this.isLiked,
    required this.id,
  });
  int likes;
  bool isLiked;
  String id;
  @override
  Widget build(BuildContext context) => StatefulBuilder(builder: (context, setState) {
        return IconButton(
          onPressed: () {
            setState(() {
              isLiked ? likes-- : likes++;
              isLiked = !isLiked;
            });
            context.read<CommentsCubit>().reactComment(context.read<UserCubit>().getProfileData.id, id);
          },
          icon: Row(
            children: [
              Text(likes.toString()),
              Icon(isLiked ? Icons.favorite : Icons.favorite_border_rounded),
            ],
          ),
        );
      });
}
