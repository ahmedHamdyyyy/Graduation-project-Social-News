import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/localization/app_locale.dart';
import '../../../../core/services/location/location.dart';
import '../../../posts/presentation/widgets/create_post.dart';
import '../../../user/logic/user_cubit.dart';
import '../../logic/global_cubit.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_nav_bar.dart';

class GlobalHome extends StatelessWidget {
  const GlobalHome({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().setMyData;
    LocationServices().checkLocationActivation(context);
    final local = AppLocale.locale(context);
    context.read<GlobalCubit>().getMapPoints;
    final pageController = PageController(initialPage: 1);
    return Scaffold(
      drawer: AppDrawer(local: local),
      appBar: AppBar(
        title: Image.asset(logoImage, height: 75, width: 75, fit: BoxFit.fitHeight),
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.searchScreen),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (page) => context.read<GlobalCubit>().setScreen(page),
        children: screens,
      ),
      bottomNavigationBar: BottomNavBar(pageController: pageController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: 'tag2',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 0,
        onPressed: () => showDialog(
          context: context,
          builder: (_) => CreatePostWidget(local: local),
        ),
        child: const Icon(Icons.add, size: 33),
      ),
    );
  }
}
