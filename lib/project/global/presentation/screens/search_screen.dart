import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/localization/app_locale.dart';
import '../../../../models/search/search_model.dart';
import '../../../posts/presentation/widgets/post_image.dart';
import '../../logic/global_cubit.dart';
import '../widgets/app_error_msg.dart';
import '../widgets/app_failure_msg.dart';
import '../widgets/app_loading_indicator.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isUser = false;
    context.read<GlobalCubit>().initSearch;
    final local = AppLocale.locale(context);
    return BlocBuilder<GlobalCubit, GlobalState>(
      buildWhen: (previous, current) =>
          previous.isUser != current.isUser || previous.searchList != current.searchList,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leadingWidth: 50,
          title: TextFormField(
            controller: search,
            onChanged: (value) => context.read<GlobalCubit>().search(value),
            decoration: InputDecoration(
              suffixIcon: StatefulBuilder(builder: (context, setState) {
                return IconButton(
                  onPressed: () {
                    setState(() => isUser = !isUser);
                    context.read<GlobalCubit>().setSearch(isUser);
                  },
                  icon: Icon(isUser ? Icons.person : Icons.article),
                );
              }),
            ),
          ),
        ),
        body: BlocBuilder<GlobalCubit, GlobalState>(
          buildWhen: (previous, current) =>
              previous.searchList != current.searchList || previous.searchState != current.searchState,
          builder: (context, state) {
            switch (state.searchState) {
              case Status.initial:
                return Center(child: Text(local.search));
              case Status.loading:
                return const AppLoadingIndicator();
              case Status.failure:
                return AppFailureMsg(failure: state.msg);
              case Status.error:
                return AppErrorMsg(error: state.error);
              case Status.success:
                return ListView.builder(
                  itemCount: state.searchList.length,
                  itemBuilder: (_, index) => _user(context, state.searchList[index], state.isUser),
                );
            }
          },
        ),
      ),
    );
  }

  ListTile _user(BuildContext context, SearchModel user, bool isUser) => ListTile(
        title: Text(user.title),
        leading: PostImage(image: user.image),
        onTap: () => Navigator.pushReplacementNamed(
          context,
          isUser ? AppRoutes.userScreen : AppRoutes.postScreen,
          arguments: user.id,
        ),
      );
}
