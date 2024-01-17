import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/global_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) => BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) => BottomAppBar(
          shape: const CircularNotchedRectangle(),
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarIcon(
                current: state.currentScreen,
                index: 0,
                icon: Icons.video_stable_outlined,
                pageController: pageController,
              ),
              NavBarIcon(
                current: state.currentScreen,
                index: 1,
                icon: Icons.heat_pump_rounded,
                pageController: pageController,
              ),
              const SizedBox(width: 35),
              NavBarIcon(
                current: state.currentScreen,
                index: 2,
                icon: Icons.local_library_outlined,
                pageController: pageController,
              ),
              NavBarIcon(
                current: state.currentScreen,
                index: 3,
                icon: Icons.person_2_rounded,
                pageController: pageController,
              ),
            ],
          ),
        ),
      );
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({
    super.key,
    required this.pageController,
    required this.index,
    required this.current,
    required this.icon,
  });

  final PageController pageController;
  final int current;
  final int index;
  final IconData icon;
  @override
  Widget build(BuildContext context) => IconButton(
        style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 1500),
          backgroundColor: MaterialStatePropertyAll(
            current == index ? Colors.white : Colors.transparent,
          ),
        ),
        onPressed: () {
          context.read<GlobalCubit>().setScreen(index);
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 250),
            curve: Curves.linear,
          );
        },
        padding: EdgeInsets.symmetric(horizontal: current == index ? 30 : 10),
        icon: Icon(
          icon,
          size: current == index ? 30 : 25,
          color: current != index ? Colors.black26 : null,
        ),
      );
}
