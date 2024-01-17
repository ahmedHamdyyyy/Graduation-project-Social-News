import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../../global/presentation/widgets/app_divider.dart';
import '../../logic/user_cubit.dart';
import 'user_callback.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Delete Account',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  appDivider,
                  const DeleteUserCallBack(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<UserCubit>().deleteUserData,
                        child: const Text('confirm'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        icon: const Icon(
          Icons.delete_rounded,
          color: Colors.blueGrey,
          size: 30,
        ),
      );
}
