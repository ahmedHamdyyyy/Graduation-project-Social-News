// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../core/services/location/location.dart';
import '../../../../core/validation/input_validation.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../models/post/post_model.dart';
import '../../../global/presentation/widgets/app_divider.dart';
import '../../../global/presentation/widgets/image_view.dart';
import '../../../global/presentation/widgets/pick_image.dart';
import '../../../user/logic/user_cubit.dart';
import '../../logic/posts_cubit.dart';
import 'post_callback.dart';
import 'post_image.dart';

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({super.key, required this.local});
  final AppLocalizations local;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final profile = context.read<UserCubit>().getProfileData;
    TextEditingController desc = TextEditingController();
    LocationServices().checkLocationActivation(context);
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
                        context.read<PostsCubit>().initCreate;
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Create Post',
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
                const CreateCallback(),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate() ||
                        !await LocationServices().checkLocationActivation(context)) return;
                    final currentPosition = await LocationServices().getCurrentPosition;
                    context.read<PostsCubit>().addPost(
                          PostModel(
                            userId: profile.id,
                            desc: desc.text,
                            img: context.read<PostsCubit>().getPostImage,
                            lat: currentPosition.latitude,
                            long: currentPosition.longitude,
                            date: DateTime.now().toString(),
                            name: '',
                            id: '',
                            userImage: '',
                            isLiked: false,
                            likes: 0,
                            filter: Filter.non,
                            comments: 0,
                          ),
                          context,
                        );
                  },
                  child: const Text('Post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
