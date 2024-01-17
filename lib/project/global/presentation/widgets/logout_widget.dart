import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../auth/presentation/widgets/auth_callback.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({super.key, required this.local});
  final AppLocalizations local;
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AuthCubit(),
        child: ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: Text(local.logout),
          onTap: () => showDialog(
            context: context,
            builder: (_) => Dialog(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        local.logout,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 20),
                      const LogoutCallBack(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(local.cancel),
                          ),
                          ElevatedButton(
                            onPressed: () => context.read<AuthCubit>().logout,
                            child: Text(local.confirm),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
