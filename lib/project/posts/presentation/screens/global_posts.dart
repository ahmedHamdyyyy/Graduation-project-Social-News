import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/colors.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../global/logic/global_cubit.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/posts_cubit.dart';
import '../widgets/post_widget.dart';

class GlobalPosts extends StatelessWidget {
  const GlobalPosts({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<PostsCubit>().setGlobalPosts;
    return BlocBuilder<PostsCubit, PostsState>(
      buildWhen: (previous, current) =>
          previous.globalPostsState != current.globalPostsState,
      builder: (context, state) {
        switch (state.globalPostsState) {
          case Status.initial:
          case Status.loading:
            return const AppLoadingIndicator();
          case Status.success:
            return const GPosts();
          case Status.error:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppErrorMsg(error: state.error),
                TextButton(
                  onPressed: () =>
                      context.read<PostsCubit>().refreshGlobalPosts,
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
                      context.read<PostsCubit>().refreshGlobalPosts,
                  child: const Text('retry'),
                ),
              ],
            );
        }
      },
    );
  }
}

class GPosts extends StatelessWidget {
  const GPosts({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<PostsCubit, PostsState>(
        buildWhen: (previous, current) =>
            previous.filter != current.filter ||
            previous.filteredPosts != current.filteredPosts ||
            previous.globalPosts != current.globalPosts,
        builder: (context, state) => Column(
          children: [
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: _buttonStyle(
                          state.filter == Filter.non,
                          context,
                        ),
                        onPressed: () =>
                            context.read<PostsCubit>().setFilter(Filter.non),
                        child: const Icon(Icons.filter_alt_off_sharp),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextButton(
                        style: _buttonStyle(
                          state.filter == Filter.sports,
                          context,
                        ),
                        onPressed: () =>
                            context.read<PostsCubit>().setFilter(Filter.sports),
                        child: const Icon(Icons.sports_esports_rounded),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextButton(
                        style: _buttonStyle(
                          state.filter == Filter.world,
                          context,
                        ),
                        onPressed: () =>
                            context.read<PostsCubit>().setFilter(Filter.world),
                        child: const Icon(Icons.location_city_rounded),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextButton(
                        style: _buttonStyle(
                          state.filter == Filter.business,
                          context,
                        ),
                        onPressed: () => context
                            .read<PostsCubit>()
                            .setFilter(Filter.business),
                        child: const Icon(Icons.business_center_rounded),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextButton(
                        style: _buttonStyle(
                          state.filter == Filter.science,
                          context,
                        ),
                        onPressed: () => context
                            .read<PostsCubit>()
                            .setFilter(Filter.science),
                        child: const Icon(Icons.science_rounded),
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async =>
                    context.read<PostsCubit>().refreshGlobalPosts,
                child: state.globalPosts.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: state.filter == Filter.non
                            ? state.globalPosts.length
                            : state.filteredPosts.length,
                        itemBuilder: (context, index) => Post(
                          post: state.filter == Filter.non
                              ? state.globalPosts[index]
                              : state.filteredPosts[index],
                        ),
                      )
                    : ListView(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 2.5),
                          const Center(child: Text('No posts until now.')),
                        ],
                      ),
              ),
            ),
          ],
        ),
      );

  ButtonStyle _buttonStyle(bool condition, BuildContext context) => ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(condition
            ? secondaryColor[context.read<GlobalCubit>().getCurrentTheme]
            : Colors.transparent),
      );
}
