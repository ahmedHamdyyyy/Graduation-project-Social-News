import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/routes.dart';
import '../../../../models/post/post_model.dart';
import '../../logic/posts_cubit.dart';
import 'post_description.dart';
import 'post_edition.dart';
import 'post_image.dart';

class Post extends StatelessWidget {
  const Post({super.key, required this.post, this.isUser = false});
  final PostModel post;
  final bool isUser;
  @override
  Widget build(BuildContext context) {
    bool isPostLiked = post.isLiked;
    int likes = post.likes;
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.userScreen, arguments: post.userId),
                        child: PostImage(image: post.userImage),
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.name,
                              textWidthBasis: TextWidthBasis.longestLine,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            // Text(
                            //   '${date.year} /${date.month} /${date.day}```${date.hour} :${date.minute}',
                            //   textWidthBasis: TextWidthBasis.longestLine,
                            //   overflow: TextOverflow.ellipsis,
                            //   style: Theme.of(context).textTheme.bodySmall,
                            // ),
                          ],
                        ),
                      ),
                      StatefulBuilder(
                        builder: (context, setState) => IconButton(
                          onPressed: () {
                            setState(() {
                              isPostLiked ? likes-- : likes++;
                              isPostLiked = !isPostLiked;
                            });
                            context.read<PostsCubit>().reactPost(post.id);
                          },
                          icon: Icon(isPostLiked ? Icons.favorite : Icons.favorite_border),
                        ),
                      ),
                      isUser ? edition(context, post) : const SizedBox.shrink(),
                    ],
                  ),
                  PostDescription(desc: post.desc),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 444, minHeight: 0),
              child: post.img != '' || post.img.isNotEmpty
                  ? SizedBox(
                      width: double.infinity,
                      child: Image.memory(
                        base64Decode(post.img),
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.commentsScreen, arguments: post.id),
                child: Text('$likes likes, ${post.comments} comments'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
