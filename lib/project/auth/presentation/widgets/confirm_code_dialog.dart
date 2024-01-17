import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/validation/input_validation.dart';
import '../../../global/presentation/widgets/app_divider.dart';
import '../../../global/presentation/widgets/input_field.dart';
import '../../logic/auth_cubit.dart';
import 'auth_callback.dart';

class ConfirmCodeDialog extends StatelessWidget {
  ConfirmCodeDialog({super.key, required this.email});
  final String email;
  final _formKey = GlobalKey<FormState>();
  final _code = TextEditingController();
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
                    'Confirm Code',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  appDivider,
                  inputField(
                    controller: _code,
                    hint: 'Enter Code',
                    validate: (value) => InputValidation.nameValidation(value),
                  ),
                  const SizedBox(height: 5),
                  const ConfirmCodeCallBack(),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      _cubit.confirmCode(_code.text, email);
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
