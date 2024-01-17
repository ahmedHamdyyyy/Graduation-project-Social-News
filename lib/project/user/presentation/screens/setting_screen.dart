import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../core/validation/input_validation.dart';
import '../../../../models/user/user_model.dart';
import '../../../global/presentation/widgets/app_divider.dart';
import '../../logic/user_cubit.dart';
import '../widgets/delete_account_widget.dart';
import '../widgets/update_password_dialog.dart';
import '../widgets/user_auth_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _name = TextEditingController(text: profileData.name);
  final _phone = TextEditingController(text: profileData.phone);
  final _email = TextEditingController(text: profileData.email);
  final _study = TextEditingController();
  final _details = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isFollowersViewed = true;
  bool isFollowingsViewed = true;
  bool isProfileDataViewed = true;
  bool isAuthenticateSuccess = false;
  DateTime date = DateTime.parse(profileData.birthDate);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Setting',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: const [DeleteAccountWidget()],
        ),
        body: BlocListener<UserCubit, UserState>(
          listenWhen: (previous, current) =>
              previous.authenticatePasswordState !=
              current.authenticatePasswordState,
          listener: (context, state) {
            state.authenticatePasswordState == Status.success
                ? isAuthenticateSuccess = true
                : isAuthenticateSuccess = false;
            setState(() {});
          },
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text('    profile.'),
                ListTile(
                  leading: const Icon(Icons.person_rounded),
                  title: TextFormField(
                    controller: _name,
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    validator: (value) => InputValidation.nameValidation(value),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: TextFormField(
                    controller: _phone,
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    validator: (value) =>
                        InputValidation.phoneValidation(value),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.school_rounded),
                  title: TextFormField(
                    controller: _study,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Enter Your Study Place'),
                    validator: (value) =>
                        InputValidation.phoneValidation(value),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.stars_rounded),
                  title: TextFormField(
                    controller: _details,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'write some caption about you'),
                    validator: (value) =>
                        InputValidation.phoneValidation(value),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.date_range_rounded),
                  title: Text('${date.day} /${date.month} /${date.year}'),
                  onTap: () => showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  ).then((value) => setState(() => date = value ?? date)),
                ),
                appDivider,
                const Text('    privacy.'),
                ListTile(
                  leading: Icon(
                    isProfileDataViewed
                        ? Icons.assignment_ind_outlined
                        : Icons.assignment_late_rounded,
                  ),
                  title: const Text('allow others view profile data'),
                  trailing: Icon(
                    isProfileDataViewed
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  onTap: () => setState(
                      () => isProfileDataViewed = !isProfileDataViewed),
                ),
                ListTile(
                  leading: Icon(
                    isFollowersViewed
                        ? Icons.account_box
                        : Icons.account_balance_wallet_sharp,
                  ),
                  title: const Text('allow others view followers'),
                  trailing: Icon(
                    isFollowersViewed
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  onTap: () =>
                      setState(() => isFollowersViewed = !isFollowersViewed),
                ),
                ListTile(
                  leading: Icon(
                    isFollowingsViewed
                        ? Icons.account_box
                        : Icons.account_balance_wallet_sharp,
                  ),
                  title: const Text('allow others view followings'),
                  trailing: Icon(
                    isFollowingsViewed
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  onTap: () =>
                      setState(() => isFollowingsViewed = !isFollowingsViewed),
                ),
                appDivider,
                Row(
                  children: [
                    const Text('    security.'),
                    const Spacer(),
                    !isAuthenticateSuccess
                        ? const UserAuthButton()
                        : const SizedBox(),
                    const SizedBox(width: 10),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: TextFormField(
                    controller: _email,
                    enabled: isAuthenticateSuccess,
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    validator: (value) =>
                        InputValidation.emailValidation(value),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.date_range_rounded),
                  title: Text(
                    '************',
                    style: TextStyle(
                      color: isAuthenticateSuccess ? Colors.black : Colors.grey,
                    ),
                  ),
                  onTap: isAuthenticateSuccess
                      ? () => updatePasswordDialog(context, profileData.id)
                      : null,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      final user = UserModel(
                        id: profileData.id,
                        name: _name.text,
                        email: _email.text,
                        phone: _phone.text,
                        image: profileData.image,
                        birthDate: date.toString(),
                        followers: profileData.followers,
                        followings: profileData.followings,
                        study: _study.text,
                        details: _details.text,
                        isFollowersViewed: isFollowersViewed,
                        isFollowingsViewed: isFollowingsViewed,
                        isProfileDataViewed: isProfileDataViewed,
                        isActive: true,
                      );
                      if (!context.read<UserCubit>().checkUpdatesFound(user)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('no changes found...')),
                        );
                        return;
                      }
                      context.read<UserCubit>().updateUserData(user);
                    },
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
