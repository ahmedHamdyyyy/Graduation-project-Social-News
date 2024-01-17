import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../core/validation/input_validation.dart';
import '../../../../models/post/post_model.dart';
import '../../../global/presentation/widgets/app_divider.dart';
import '../../../global/presentation/widgets/image_view.dart';
import '../../../global/presentation/widgets/pick_image.dart';
import '../../../user/logic/user_cubit.dart';
import '../../logic/posts_cubit.dart';
import 'post_callback.dart';
import 'post_image.dart';

class UpdatePostWidget extends StatelessWidget {
  const UpdatePostWidget({super.key, required this.post});
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final profile = context.read<UserCubit>().getProfileData;
    context.read<PostsCubit>().pickImage(post.img);
    TextEditingController desc = TextEditingController()..text = post.desc;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<PostsCubit>().initUpdate;
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Update Post',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
                appDivider,
                Row(
                  children: [
                    PostImage(image: profile.image),
                    Text(
                      profile.name,
                      textWidthBasis: TextWidthBasis.longestLine,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    const PickImageWidget(),
                  ],
                ),
                TextFormField(
                  controller: desc,
                  maxLines: null,
                  validator: (value) => InputValidation.textValidation(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(hintText: 'description'),
                ),
                const SizedBox(height: 5),
                const ImageView(),
                const SizedBox(height: 10),
                const UpdateCallback(),
                ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    final newPost = PostModel(
                      userId: profile.id,
                      desc: desc.text,
                      filter: Filter.non,
                      img: context.read<PostsCubit>().getPostImage,
                      lat: post.lat,
                      long: post.long,
                      date: post.date,
                      name: post.name,
                      id: post.id,
                      userImage: profile.image,
                      isLiked: post.isLiked,
                      likes: post.likes,
                      comments: post.comments,
                    );
                    if (post.desc != newPost.desc || post.img != newPost.img) {
                      context.read<PostsCubit>().editPost(newPost);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
