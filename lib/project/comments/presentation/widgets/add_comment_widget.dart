import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../core/validation/input_validation.dart';
import '../../../../models/comment/comment_model.dart';
import '../../../posts/presentation/widgets/post_image.dart';
import '../../logic/comments_cubit.dart';
import 'comments_callback.dart';

class AddCommentWidget extends StatelessWidget {
  AddCommentWidget({super.key, required this.postId});
  final String postId;
  final _desc = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.clear),
                          ),
                          const Spacer(),
                          Text(profileData.name),
                          const SizedBox(width: 2),
                          PostImage(image: profileData.image),
                        ],
                      ),
                      const SizedBox(height: 2),
                      TextFormField(
                        controller: _desc,
                        validator: (value) =>
                            InputValidation.textValidation(value),
                      ),
                    ],
                  ),
                ),
              ),
              const CreateCommentCallback(),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  context.read<CommentsCubit>().addComment(CommentModel(
                        userId: profileData.id,
                        postId: postId,
                        desc: _desc.text,
                        date: DateTime.now().toString(),
                        name: '',
                        userImage: '',
                        id: '',
                        isLiked: false,
                        likes: 0,
                      ));
                },
                child: const Text('add'),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      );
}
