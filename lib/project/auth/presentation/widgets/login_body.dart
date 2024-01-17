import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/colors.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/validation/input_validation.dart';
import '../../../global/presentation/widgets/input_field.dart';
import '../../../global/presentation/widgets/password_field.dart';
import '../../logic/auth_cubit.dart';
import 'auth_callback.dart';
import 'forget_password_dialog.dart';

Widget loginBody(BuildContext context) {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  return Form(
    key: formKey,
    child: Column(
      children: [
        Text(
          'login',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 25),
        inputField(
          controller: emailController,
          hint: 'Enter Your Email',
          validate: InputValidation.emailValidation,
        ),
        const SizedBox(height: 10),
        passwordField(
          controller: passwordController,
          hint: 'Enter Your Password',
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Do not have an account ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.registrationScreen),
              child: Text(
                'Register Now.?',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: custom[0]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => ForgetPasswordDialog(),
          ),
          child: Text(
            'forget Password.?',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: custom[0],
                ),
          ),
        ),
        const SizedBox(height: 25),
        const LoginCallBack(),
        ElevatedButton(
          onPressed: () async {
            if (!formKey.currentState!.validate()) return;
            context.read<AuthCubit>().login(
                  emailController.text,
                  passwordController.text,
                );
          },
          child: const Text('logIn'),
        ),
        const SizedBox(height: 75),
      ],
    ),
  );
}
