import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/validation/input_validation.dart';
import '../../../../models/user/user_model.dart';
import '../../../global/presentation/widgets/input_field.dart';
import '../../../global/presentation/widgets/password_field.dart';
import '../../logic/auth_cubit.dart';
import 'auth_callback.dart';

Widget registerBody(BuildContext context) {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime birthDate = DateTime(2001);
  return Form(
    key: formKey,
    child: Column(
      children: [
        Text(
          'Registration',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 10),
        inputField(
          controller: nameController,
          hint: 'Enter your Name',
          validate: InputValidation.nameValidation,
        ),
        const SizedBox(height: 10),
        inputField(
          controller: phoneController,
          hint: 'Enter your Phone Number',
          validate: InputValidation.phoneValidation,
        ),
        const SizedBox(height: 10),
        inputField(
          controller: emailController,
          hint: 'Enter your Email',
          validate: InputValidation.emailValidation,
        ),
        const SizedBox(height: 10),
        passwordField(
          controller: passwordController,
          hint: 'Enter Your Password',
        ),
        const SizedBox(height: 10),
        passwordField(
          controller: confirmController,
          hint: 'Confirm Your Password',
          isConfirm: true,
          password: passwordController,
        ),
        StatefulBuilder(
          builder: (BuildContext context, setState) => TextButton(
            onPressed: () => showDatePicker(
              context: context,
              initialDate: birthDate,
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
            ).then((date) => setState(() => birthDate = date!)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${birthDate.year} / ${birthDate.month} / ${birthDate.day}',
                ),
                const Icon(Icons.date_range)
              ],
            ),
          ),
        ),
        RegisterCallBack(email: emailController),
        ElevatedButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) return;
            final user = UserModel(
              id: '',
              name: nameController.text,
              email: emailController.text,
              phone: phoneController.text,
              image: context.read<AuthCubit>().getImage,
              birthDate: birthDate.toString(),
              followers: const [],
              followings: const [],
              study: '',
              isActive: false,
              details: '',
              isFollowersViewed: false,
              isFollowingsViewed: false,
              isProfileDataViewed: false,
            );
            context.read<AuthCubit>().register(user, passwordController.text);
          },
          child: const Text('Register'),
        ),
        const SizedBox(height: 5),
      ],
    ),
  );
}
