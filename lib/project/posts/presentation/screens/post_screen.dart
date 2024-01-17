import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/app_constants/constants.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/posts_cubit.dart';
import '../widgets/post_widget.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    context.read<PostsCubit>().getPost(id);
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          switch (state.getPostState) {
            case Status.initial || Status.success:
              return Post(post: state.searchPost);
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
            case Status.error:
              return AppErrorMsg(error: state.error);
            case Status.loading:
              return const AppLoadingIndicator();
          }
        },
      ),
    );
  }
}
