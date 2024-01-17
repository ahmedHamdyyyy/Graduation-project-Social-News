import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/posts_cubit.dart';

class CreateCallback extends StatelessWidget {
  const CreateCallback({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<PostsCubit, PostsState>(
        buildWhen: (previous, current) =>
            previous.createPostState != current.createPostState,
        builder: (context, state) {
          switch (state.createPostState) {
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
              context.read<PostsCubit>().initCreate;
              return const SizedBox();
          }
        },
      );
}

class UpdateCallback extends StatelessWidget {
  const UpdateCallback({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      buildWhen: (previous, current) =>
          previous.updatePostState != current.updatePostState,
      builder: (context, state) {
        switch (state.updatePostState) {
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
            context.read<PostsCubit>().initUpdate;
            return const SizedBox();
        }
      },
    );
  }
}

class DeleteCallback extends StatelessWidget {
  const DeleteCallback({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      buildWhen: (previous, current) =>
          previous.deletePostState != current.deletePostState,
      builder: (context, state) {
        switch (state.deletePostState) {
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
            context.read<PostsCubit>().initDelete;
            return const SizedBox();
        }
      },
    );
  }
}
