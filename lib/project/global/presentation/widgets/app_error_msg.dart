import 'package:flutter/material.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../core/localization/app_locale.dart';

class AppErrorMsg extends StatelessWidget {
  const AppErrorMsg({super.key, required this.error});
  final ErrorType error;
  @override
  Widget build(BuildContext context) =>
      Center(child: Text(AppLocale.displayError(context, error)));
}
