import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/post/post_model.dart';
import '../../logic/posts_cubit.dart';
import 'post_callback.dart';
import 'update_post.dart';

Widget edition(BuildContext context, PostModel post) => PopupMenuButton<bool>(
      onSelected: (value) => value ? edit(context, post) : delete(context, post),
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: true,
          child: Row(children: [Icon(Icons.edit), Text(' Edit')]),
        ),
        PopupMenuItem(
          value: false,
          child: Row(children: [Icon(Icons.delete), Text(' Delete')]),
        ),
      ],
    );

Future<dynamic> edit(BuildContext context, PostModel post) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => UpdatePostWidget(post: post),
    );

Future<dynamic> delete(BuildContext context, PostModel post) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Delete Post',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const DeleteCallback(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<PostsCubit>().initDelete;
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => context.read<PostsCubit>().deletePost(
                          post.id,
                        ),
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
