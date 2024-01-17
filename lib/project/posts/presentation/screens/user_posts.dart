import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../models/post/post_model.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/posts_cubit.dart';
import '../widgets/post_widget.dart';

class UserPosts extends StatelessWidget {
  const UserPosts({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    context.read<PostsCubit>().setUserPosts(id);
    return BlocBuilder<PostsCubit, PostsState>(
      buildWhen: (previous, current) =>
          previous.userPostsState != current.userPostsState,
      builder: (context, state) {
        switch (state.userPostsState) {
          case Status.initial:
          case Status.loading:
            return const AppLoadingIndicator();
          case Status.success:
            return PostsList(
                posts: state.userPosts, isUser: id == profileData.id);
          case Status.error:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppErrorMsg(error: state.error),
                TextButton(
                  onPressed: () => context
                      .read<PostsCubit>()
                      .refreshUserPosts( id),
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
                  onPressed: () => context
                      .read<PostsCubit>()
                      .refreshUserPosts(id),
                  child: const Text('retry'),
                ),
              ],
            );
        }
      },
    );
  }
}

class PostsList extends StatelessWidget {
  const PostsList({super.key, required this.posts, required this.isUser});
  final List<PostModel> posts;
  final bool isUser;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: posts.isNotEmpty
          ? RefreshIndicator(
              onRefresh: () async =>
                  context.read<PostsCubit>().refreshUserPosts,
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: posts.length,
                itemBuilder: (context, index) => Post(
                  post: posts[index],
                  isUser: isUser,
                ),
              ),
            )
          : const Center(child: Text('No posts until now.')),
    );
  }
}
