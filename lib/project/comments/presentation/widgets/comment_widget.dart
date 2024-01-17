import 'package:flutter/material.dart';
import '../../../../models/comment/comment_model.dart';
import '../../../posts/presentation/widgets/post_image.dart';
import 'comment_react_button.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key, required this.comment});
  final CommentModel comment;

  @override
  Widget build(BuildContext context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 35),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommentReactButton(
                        isLiked: comment.isLiked,
                        likes: comment.likes,
                        id: comment.id,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(comment.name.length <= 20
                              ? comment.name
                              : '${comment.name.substring(0, 20)}~'),
                          Text(
                            '${commentDate(comment.date)} ``` ${commentTime(comment.date)}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(width: 2),
                      PostImage(image: comment.userImage),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(comment.desc),
                ],
              ),
            ),
          ),
        ),
      );
}

String commentDate(String value) {
  final date = DateTime.parse(value);
  final today = DateTime.now();
  if (date.year == today.year && date.month == today.month) {
    if (date.day == today.day) return 'today';
    if (date.day == today.day - 1) return 'yesterDay';
  }
  return '${date.year} /${date.month} /${date.day}';
}

String commentTime(String value) {
  final date = DateTime.parse(value);
  final today = DateTime.now();
  if (date.hour == today.hour && date.minute == today.minute) return 'now';
  return '${date.hour} :${date.minute}';
}
