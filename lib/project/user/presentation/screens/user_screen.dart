import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../../friends/presentation/widgets/custom_buttons.dart';
import '../../../posts/logic/posts_cubit.dart';
import '../../../posts/presentation/screens/user_posts.dart';
import '../../logic/user_cubit.dart';
import '../widgets/user_header.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    context.read<PostsCubit>().setUserPosts(id);
    context.read<UserCubit>().setUserData(id);
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<PostsCubit>().refreshUserPosts(id);
          context.read<UserCubit>().refreshUserData(id);
        },
        child: ListView(
          children: [
            const UserHeaderWidget(),
            CustomButtons(id: id),
            UserPosts(id: id),
          ],
        ),
      ),
    );
  }
}
