import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/constants/app_constants/constants.dart';

class AppLoadingIndicator extends StatefulWidget {
  const AppLoadingIndicator({super.key});

  @override
  State<AppLoadingIndicator> createState() => _AppLoadingIndicatorState();
}

class _AppLoadingIndicatorState extends State<AppLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Center(
          child: Lottie.asset(
            loadingAsset,
            height: 15,
            controller: _controller,
            onLoaded: (c) => _controller.repeat(),
          ),
        ),
      );
}
