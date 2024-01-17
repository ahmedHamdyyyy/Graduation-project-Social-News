import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/validation/input_validation.dart';
import '../../../global/presentation/widgets/app_divider.dart';
import '../../../global/presentation/widgets/input_field.dart';
import '../../logic/auth_cubit.dart';
import 'auth_callback.dart';

class ForgetPasswordDialog extends StatelessWidget {
  ForgetPasswordDialog({super.key});
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _cubit = AuthCubit();
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => _cubit,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Forget Password',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  appDivider,
                  inputField(
                    controller: _email,
                    hint: 'Enter Your Email',
                    validate: (value) => InputValidation.nameValidation(value),
                  ),
                  const SizedBox(height: 5),
                  ForgetPasswordCallback(email: _email.text),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      _cubit.forgetPassword(_email.text);
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
