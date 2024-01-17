import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../logic/global_cubit.dart';

class LangWidget extends StatelessWidget {
  const LangWidget({super.key, required this.local});
  final AppLocalizations local;
  @override
  Widget build(BuildContext context) {
    String lang = context.read<GlobalCubit>().getCurrentLang;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), border: Border.all()),
        child: Text(
          context.read<GlobalCubit>().getCurrentLang,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      title: Text(local.language),
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
                    'اللغة العربية',
                    lang == 'ar',
                    () => setState(() => lang = 'ar'),
                  ),
                  _themeButton(
                    context,
                    'English',
                    lang == 'en',
                    () => setState(() => lang = 'en'),
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
                          context.read<GlobalCubit>().setLang(lang);
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

  ButtonStyle _buttonStyle(bool condition) {
    return ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        condition ? secondaryColor[0] : Colors.transparent,
      ),
    );
  }
}
