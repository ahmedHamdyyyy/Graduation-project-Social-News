import 'package:flutter/material.dart';
// import '../../../../core/localization/app_locale.dart';

class AppFailureMsg extends StatelessWidget {
  const AppFailureMsg({super.key, required this.failure});
  final String failure;
  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          failure,
          // AppLocale.displayFailure(context, failure),
        ),
      );
}
