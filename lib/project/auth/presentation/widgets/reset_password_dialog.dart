import 'package:flutter/material.dart';
import '../../../global/presentation/widgets/app_divider.dart';
import '../../../global/presentation/widgets/password_field.dart';
import '../../logic/auth_cubit.dart';
import 'auth_callback.dart';

class ResetPasswordDialog extends StatelessWidget {
  ResetPasswordDialog({super.key, required this.email});
  final _formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirm = TextEditingController();
  final _cubit = AuthCubit();
  final String email;
  @override
  Widget build(BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Reset Password',
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
                const ResetPasswordCallback(),
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    _cubit.resetPassword(password.text, email);
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      );
}
