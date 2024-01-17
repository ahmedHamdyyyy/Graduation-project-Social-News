import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/friends_cubit.dart';
import '../widgets/friends_view.dart';

class UserFollowings extends StatelessWidget {
  const UserFollowings({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    context.read<FriendsCubit>().setUserFollowings(id);
    return BlocBuilder<FriendsCubit, FriendsState>(
      buildWhen: (previous, current) =>
          previous.userFollowingsState != current.userFollowingsState,
      builder: (context, state) {
        switch (state.userFollowingsState) {
          case Status.initial:
          case Status.loading:
            return const AppLoadingIndicator();
          case Status.success:
            return FriendsWidget(friends: state.userFollowings);
          case Status.error:
            return AppErrorMsg(error: state.error);
          case Status.failure:
            return AppFailureMsg(failure: state.msg);
        }
      },
    );
  }
}
