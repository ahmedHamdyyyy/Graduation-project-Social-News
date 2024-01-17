import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../user/logic/user_cubit.dart';
import '../../../user/presentation/widgets/custom_button_style.dart';
import '../../logic/friends_cubit.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    final profileId = context.read<UserCubit>().getProfileData.id;
    return BlocBuilder<FriendsCubit, FriendsState>(
      buildWhen: (previous, current) =>
          previous.isFollowing != current.isFollowing,
      builder: (context, state) {
        bool isFollowing = state.isFollowing;
        return StatefulBuilder(
          builder: (context, setState) => ElevatedButton(
            onPressed: () {
              setState(() => isFollowing = !isFollowing);
              context.read<FriendsCubit>().followUser(profileId, id);
            },
            style: customButtonStyle(left: 35, padding: 15),
            child: Row(
              children: [
                isFollowing
                    ? const Icon(Icons.mobile_friendly_rounded)
                    : const SizedBox(),
                const Text(' follow'),
              ],
            ),
          ),
        );
      },
    );
  }
}
