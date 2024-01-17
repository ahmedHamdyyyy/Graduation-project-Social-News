import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../../user/logic/user_cubit.dart';
import '../../logic/friends_cubit.dart';
import '../widgets/friends_view.dart';

class ProfileFollowers extends StatelessWidget {
  const ProfileFollowers({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<FriendsCubit>().setProfileFollowers(
          context.read<UserCubit>().getProfileData.id,
        );
    return BlocBuilder<FriendsCubit, FriendsState>(
      buildWhen: (previous, current) =>
          previous.profileFollowersState != current.profileFollowersState,
      builder: (context, state) {
        switch (state.profileFollowersState) {
          case Status.initial:
          case Status.loading:
            return const AppLoadingIndicator();
          case Status.success:
            return FriendsWidget(friends: state.profileFollowers);
          case Status.error:
            return AppErrorMsg(error: state.error);
          case Status.failure:
            return AppFailureMsg(failure: state.msg);
        }
      },
    );
  }
}