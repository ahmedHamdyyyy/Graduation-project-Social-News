import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../global/presentation/widgets/app_divider.dart';
import '../../../global/presentation/widgets/password_field.dart';
import '../../logic/user_cubit.dart';
import 'user_callback.dart';

class UserAuthButton extends StatelessWidget {
  const UserAuthButton({super.key});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (_) {
            final password = TextEditingController();
            final confirm = TextEditingController();
            final formKey = GlobalKey<FormState>();
            context.read<UserCubit>().initAuth;
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Authentication',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      appDivider,
                      passwordField(controller: password, hint: 'password'),
                      const SizedBox(height: 5),
                      passwordField(
                        controller: confirm,
                        isConfirm: true,
                        hint: 'confirm password',
                        password: password,
                      ),
                      const SizedBox(height: 5),
                      const UserAuthCallBack(),
                      ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          context
                              .read<UserCubit>()
                              .authenticatePassword(password.text);
                        },
                        child: const Text('Auth'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        child: const Icon(Icons.connect_without_contact_rounded),
      );
}
