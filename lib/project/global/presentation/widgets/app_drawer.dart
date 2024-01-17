import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../config/routes/routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../user/logic/user_cubit.dart';
import 'app_divider.dart';
import 'lang_widget.dart';
import 'logout_widget.dart';
import 'theme_widget.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.local});
  final AppLocalizations local;
  @override
  Widget build(BuildContext context) => BlocBuilder<UserCubit, UserState>(
        buildWhen: (previous, current) => previous.myData != current.myData,
        builder: (context, state) => Drawer(
          width: 222,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: state.myData.image != ''
                          ? Image.memory(base64Decode(state.myData.image),
                              height: 150, width: 150, fit: BoxFit.cover)
                          : Image.asset(personImage, fit: BoxFit.fitHeight, height: 150, width: 150),
                    ),
                  ),
                  ListTile(
                    title: Text(state.myData.name, textAlign: TextAlign.center),
                  ),
                  appDivider,
                  ThemeWidget(local: local),
                  LangWidget(local: local),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(local.profileSetting),
                    onTap: () => Navigator.pushNamed(context, AppRoutes.settingScreen),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline_rounded),
                    title: Text(local.about),
                    onTap: () => Navigator.pushNamed(context, AppRoutes.aboutScreen),
                    // => Navigator.pushNamed(context, AppRoutes.about),
                  ),
                  LogOutWidget(local: local),
                ],
              ),
            ),
          ),
        ),
      );
}
