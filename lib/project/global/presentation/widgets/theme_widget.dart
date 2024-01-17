import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../logic/global_cubit.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key, required this.local});
  final AppLocalizations local;
  @override
  Widget build(BuildContext context) {
    int theme = context.read<GlobalCubit>().getCurrentTheme;
    return ListTile(
      leading: const Icon(Icons.color_lens_rounded, size: 30),
      title: Text(local.theme),
      onTap: () {
        Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          builder: (_) => Container(
            padding: const EdgeInsets.all(10),
            height: 165,
            width: double.infinity,
            child: StatefulBuilder(
              builder: (context, setState) => Column(
                children: [
                  _themeButton(
                    context,
                    'white theme',
                    theme == 0,
                    () => setState(() => theme = 0),
                  ),
                  _themeButton(
                    context,
                    'dark theme',
                    theme == 1,
                    () => setState(() => theme = 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(local.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<GlobalCubit>().setTheme(theme);
                          Navigator.pop(context);
                        },
                        child: Text(local.confirm),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _themeButton(
    BuildContext context,
    String text,
    bool condition,
    void Function() onTap,
  ) =>
      Row(
        children: [
          Expanded(
            child: TextButton(
              style: _buttonStyle(condition),
              onPressed: onTap,
              child: Text(text),
            ),
          ),
        ],
      );

  ButtonStyle _buttonStyle(bool condition) => ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(condition ? secondaryColor[0] : Colors.transparent));
}
