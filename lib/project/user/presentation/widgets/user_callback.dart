import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../config/routes/routes.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/user_cubit.dart';

class UserAuthCallBack extends StatelessWidget {
  const UserAuthCallBack({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<UserCubit, UserState>(
        buildWhen: (previous, current) =>
            previous.authenticatePasswordState !=
            current.authenticatePasswordState,
        builder: (context, state) {
          switch (state.authenticatePasswordState) {
            case Status.success:
              Navigator.pop(context);
              return const SizedBox();
            case Status.initial:
              return const SizedBox();
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.error:
              return AppErrorMsg(error: state.error);
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
          }
        },
      );
}

class DeleteUserCallBack extends StatelessWidget {
  const DeleteUserCallBack({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<UserCubit, UserState>(
        listenWhen: (previous, current) =>
            previous.deleteMyDataState != current.deleteMyDataState,
        buildWhen: (previous, current) =>
            previous.deleteMyDataState != current.deleteMyDataState,
        listener: (context, state) {
          if (state.deleteMyDataState == Status.success) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.loginScreen,
              (route) => false,
            );
            context.read<UserCubit>().initDelete;
          }
        },
        builder: (context, state) {
          switch (state.deleteMyDataState) {
            case Status.success:
              return const SizedBox();
            case Status.initial:
              return const SizedBox();
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.error:
              return AppErrorMsg(error: state.error);
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
          }
        },
      );
}

class UpdatePasswordCallBack extends StatelessWidget {
  const UpdatePasswordCallBack({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<UserCubit, UserState>(
        listenWhen: (previous, current) =>
            previous.updatePasswordState != current.updatePasswordState,
        buildWhen: (previous, current) =>
            previous.updatePasswordState != current.updatePasswordState,
        listener: (context, state) {
          if (state.updatePasswordState == Status.success) {
            Navigator.pop(context);
            context.read<UserCubit>().initUpdatePassword;
          }
        },
        builder: (context, state) {
          switch (state.updatePasswordState) {
            case Status.success:
              return const SizedBox();
            case Status.initial:
              return const SizedBox();
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.error:
              return AppErrorMsg(error: state.error);
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
          }
        },
      );
}
