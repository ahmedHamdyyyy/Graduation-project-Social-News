import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/comments_cubit.dart';
import '../widgets/add_comment_widget.dart';
import '../widgets/comment_widget.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key, required this.postId});
  final String postId;

  @override
  Widget build(BuildContext context) {
    context.read<CommentsCubit>().getPostComments(postId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments', style: TextStyle(color: Colors.grey)),
      ),
      body: BlocBuilder<CommentsCubit, CommentsState>(
        buildWhen: (previous, current) =>
            previous.getCommentsState != current.getCommentsState,
        builder: (context, state) {
          switch (state.getCommentsState) {
            case Status.initial || Status.loading:
              return const AppLoadingIndicator();
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
            case Status.error:
              return AppErrorMsg(error: state.error);
            case Status.success:
              return CommentsScreenBody(postId: postId);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () => showDialog(
          context: context,
          builder: (_) => AddCommentWidget(postId: postId),
        ),
        child: const Icon(Icons.comment_rounded, size: 22),
      ),
    );
  }
}

class CommentsScreenBody extends StatelessWidget {
  const CommentsScreenBody({super.key, required this.postId});
  final String postId;
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CommentsCubit, CommentsState>(
        buildWhen: (previous, current) => previous.comments != current.comments,
        builder: (context, state) => RefreshIndicator(
          onRefresh: () async =>
              context.read<CommentsCubit>().getPostComments(postId),
          child: state.comments.isNotEmpty
              ? ListView.builder(
                  itemCount: state.comments.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) => CommentWidget(
                    comment: state.comments[index],
                  ),
                )
              : const Center(child: Text('no comments added')),
        ),
      );
}
