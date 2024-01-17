import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../../user/logic/user_cubit.dart';
import '../../logic/friends_cubit.dart';
import '../widgets/friends_view.dart';

class ProfileFollowings extends StatelessWidget {
  const ProfileFollowings({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FriendsCubit>().setProfileFollowings(
          context.read<UserCubit>().getProfileData.id,
        );
    return BlocBuilder<FriendsCubit, FriendsState>(
      buildWhen: (previous, current) =>
          previous.profileFollowingsState != current.profileFollowingsState,
      builder: (context, state) {
        switch (state.profileFollowingsState) {
          case Status.initial:
          case Status.loading:
            return const AppLoadingIndicator();
          case Status.success:
            return FriendsWidget(friends: state.profileFollowings);
          case Status.error:
            return AppErrorMsg(error: state.error);
          case Status.failure:
            return AppFailureMsg(failure: state.msg);
        }
      },
    );
  }
}
