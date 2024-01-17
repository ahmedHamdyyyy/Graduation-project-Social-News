import 'package:flutter/material.dart';
import '../../../../config/routes/routes.dart';
import '../../../../models/post/post_generated_model.dart';
import 'post_description.dart';

class PostGeneratedWidget extends StatelessWidget {
  const PostGeneratedWidget({super.key, required this.post});
  final PostGenerated post;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, AppRoutes.generatedPostPosts, arguments: post.id),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: PostDescription(desc: post.postString),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
