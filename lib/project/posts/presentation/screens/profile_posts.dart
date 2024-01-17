import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../models/post/post_model.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/posts_cubit.dart';
import '../widgets/post_widget.dart';

class ProfilePosts extends StatelessWidget {
  const ProfilePosts({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          switch (state.profilePostsState) {
            case Status.initial:
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.success:
              return Posts(posts: state.profilePosts);
            case Status.error:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppErrorMsg(error: state.error),
                  TextButton(
                    onPressed: () =>
                        context.read<PostsCubit>().refreshProfilePosts,
                    child: const Text('retry'),
                  ),
                ],
              );
            case Status.failure:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppFailureMsg(failure: state.msg),
                  TextButton(
                    onPressed: () =>
                        context.read<PostsCubit>().refreshProfilePosts,
                    child: const Text('retry'),
                  ),
                ],
              );
          }
        },
      );
}

class Posts extends StatelessWidget {
  const Posts({super.key, required this.posts});
  final List<PostModel> posts;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: posts.isNotEmpty
          ? ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: posts.length,
              itemBuilder: (context, index) => Post(
                post: posts[index],
                isUser: true,
              ),
            )
          : const Center(child: Text('No posts until now.')),
    );
  }
}
