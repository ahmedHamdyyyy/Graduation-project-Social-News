import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../config/routes/routes.dart';
import '../../../global/logic/global_cubit.dart';
import '../../../user/presentation/widgets/custom_button_style.dart';
import 'follow_widget.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons({super.key, required this.id});

  final String id;
  @override
  Widget build(BuildContext context) {
    final isUser = id != profileData.id;
    final isEnglish = context.read<GlobalCubit>().getCurrentLang == 'en';
    return Container(
      height: 35,
      width: double.infinity,
      alignment: AlignmentDirectional.center,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            isUser ? FollowButton(id: id) : const SizedBox(),
            isUser ? divider : const SizedBox(),
            ElevatedButton(
              style: isEnglish ? left(isUser) : right(isUser),
              onPressed: () => Navigator.pushNamed(
                  context, AppRoutes.friendsScreen,
                  arguments: {
                    'isUser': isUser,
                    'isFollowers': true,
                    'id': id,
                  }),
              child: const Text('followers'),
            ),
            divider,
            ElevatedButton(
              style: isEnglish ? right(false) : right(false),
              onPressed: () => Navigator.pushNamed(
                  context, AppRoutes.friendsScreen,
                  arguments: {
                    'isUser': isUser,
                    'isFollowers': false,
                    'id': id,
                  }),
              child: const Text('followings'),
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle right(bool isUser) {
    return customButtonStyle(
      right: isUser ? 0 : 35,
      padding: isUser ? 5 : 15,
    );
  }

  ButtonStyle left(bool isUser) {
    return customButtonStyle(
      left: isUser ? 0 : 35,
      padding: isUser ? 5 : 15,
    );
  }

  Widget get divider => Container(
      color: const Color.fromARGB(255, 172, 172, 172), height: 40, width: 1);
}
