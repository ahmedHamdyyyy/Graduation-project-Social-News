import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../models/post/post_generated_model.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/posts_cubit.dart';
import '../widgets/post_generated_widget.dart';

class SummaryPosts extends StatelessWidget {
  const SummaryPosts({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<PostsCubit>().setSummaryPosts;
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        switch (state.summaryPostsState) {
          case Status.initial:
          case Status.loading:
            return const AppLoadingIndicator();
          case Status.success:
            return Posts(posts: state.summaryPosts);
          case Status.error:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppErrorMsg(error: state.error),
                TextButton(
                  onPressed: () =>
                      context.read<PostsCubit>().refreshSummaryPosts,
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
                      context.read<PostsCubit>().refreshSummaryPosts,
                  child: const Text('retry'),
                ),
              ],
            );
        }
      },
    );
  }
}

class Posts extends StatelessWidget {
  const Posts({super.key, required this.posts});
  final List<PostGenerated> posts;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<PostsCubit>().refreshSummaryPosts,
      child: posts.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: posts.length,
              itemBuilder: (context, index) => PostGeneratedWidget(
                post: posts[index],
              ),
            )
          : ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 2.5),
                const Center(child: Text('No posts until now.')),
              ],
            ),
    );
  }
}
