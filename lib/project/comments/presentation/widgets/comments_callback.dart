import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/comments_cubit.dart';

class CreateCommentCallback extends StatelessWidget {
  const CreateCommentCallback({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CommentsCubit, CommentsState>(
        buildWhen: (previous, current) =>
            previous.addCommentState != current.addCommentState,
        builder: (context, state) {
          switch (state.addCommentState) {
            case Status.initial:
              return const SizedBox();
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.error:
              return AppErrorMsg(error: state.error);
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
            case Status.success:
              Navigator.pop(context);
              context.read<CommentsCubit>().initCreate;
              return const SizedBox();
          }
        },
      );
}

class DeleteCommentCallback extends StatelessWidget {
  const DeleteCommentCallback({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CommentsCubit, CommentsState>(
        buildWhen: (previous, current) =>
            previous.deleteCommentState != current.deleteCommentState,
        builder: (context, state) {
          switch (state.deleteCommentState) {
            case Status.initial || Status.loading:
              return const AppLoadingIndicator();
            case Status.error:
              return AppErrorMsg(error: state.error);
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
            case Status.success:
              Navigator.pop(context);
              context.read<CommentsCubit>().initDelete;
              return const SizedBox();
          }
        },
      );
}
