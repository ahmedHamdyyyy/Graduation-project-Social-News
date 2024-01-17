import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../models/post/post_model.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/posts_cubit.dart';
import '../widgets/post_widget.dart';

class MapPointPosts extends StatelessWidget {
  const MapPointPosts({super.key, required this.ids});
  final List<String> ids;
  @override
  Widget build(BuildContext context) {
    context.read<PostsCubit>().getMapPointPosts(ids);
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PostsCubit, PostsState>(
        buildWhen: (previous, current) =>
            previous.mapPointPostsState != current.mapPointPostsState,
        builder: (context, state) {
          switch (state.mapPointPostsState) {
            case Status.initial:
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.success:
              return GPosts(posts: state.mapPostPosts);
            case Status.error:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppErrorMsg(error: state.error),
                  TextButton(
                    onPressed: () =>
                        context.read<PostsCubit>().getMapPointPosts(ids),
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
                        context.read<PostsCubit>().getMapPointPosts(ids),
                    child: const Text('retry'),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}

class GPosts extends StatelessWidget {
  const GPosts({super.key, required this.posts});
  final List<PostModel> posts;
  @override
  Widget build(BuildContext context) => posts.isNotEmpty
      ? ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: posts.length,
          itemBuilder: (context, index) => Post(post: posts[index]),
        )
      : const Center(
          child: Text('no posts until now'),
        );
}
