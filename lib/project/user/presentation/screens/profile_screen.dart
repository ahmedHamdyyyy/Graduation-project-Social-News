import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../friends/presentation/widgets/custom_buttons.dart';
import '../../../posts/logic/posts_cubit.dart';
import '../../../posts/presentation/screens/profile_posts.dart';
import '../../logic/user_cubit.dart';
import '../widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = context.read<UserCubit>().getProfileData.id;
    context.read<PostsCubit>().setProfilePosts;
    context.read<UserCubit>().setMyData;
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserCubit>().refreshProfileData;
        context.read<PostsCubit>().refreshProfilePosts;
      },
      child: ListView(
        children: [
          const ProfileHeaderWidget(),
          CustomButtons(id: id),
          const ProfilePosts(),
        ],
      ),
    );
  }
}
