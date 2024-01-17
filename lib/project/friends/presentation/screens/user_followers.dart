import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/friends_cubit.dart';
import '../widgets/friends_view.dart';

class UserFollowers extends StatelessWidget {
  const UserFollowers({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    context.read<FriendsCubit>().setUserFollowers(id);
    return BlocBuilder<FriendsCubit, FriendsState>(
      buildWhen: (previous, current) =>
          previous.userFollowersState != current.userFollowersState,
      builder: (context, state) {
        switch (state.userFollowersState) {
          case Status.initial:
          case Status.loading:
            return const AppLoadingIndicator();
          case Status.success:
            return FriendsWidget(friends: state.userFollowers);
          case Status.error:
            return AppErrorMsg(error: state.error);
          case Status.failure:
            return AppFailureMsg(failure: state.msg);
        }
      },
    );
  }
}
