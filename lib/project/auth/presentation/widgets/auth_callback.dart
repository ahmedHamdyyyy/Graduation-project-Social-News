import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../config/routes/routes.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../../global/presentation/widgets/app_loading_indicator.dart';
import '../../logic/auth_cubit.dart';
import 'confirm_code_dialog.dart';
import 'confirm_email_dialog.dart';
import 'reset_password_dialog.dart';

class RegisterCallBack extends StatelessWidget {
  const RegisterCallBack({super.key, required this.email});
  final TextEditingController email;

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.registerState != current.registerState,
        listener: (context, state) {
          state.registerState == Status.success
              ? showDialog(
                  context: context,
                  builder: (_) => ConfirmCodeDialog(email: email.text),
                )
              : null;
        },
        buildWhen: (previous, current) =>
            previous.registerState != current.registerState,
        builder: (context, state) {
          switch (state.registerState) {
            case Status.initial || Status.success:
              return const SizedBox();
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.error:
              return AppErrorMsg(error: state.errorType);
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
          }
        },
      );
}

class LoginCallBack extends StatelessWidget {
  const LoginCallBack({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.loginState != current.loginState,
        listener: (context, state) => state.loginState == Status.success
            ? Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.globalScreen, (route) => false)
            : null,
        buildWhen: (previous, current) =>
            previous.loginState != current.loginState,
        builder: (context, state) {
          switch (state.loginState) {
            case Status.initial || Status.success:
              return const SizedBox();
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.error:
              return AppErrorMsg(error: state.errorType);
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
          }
        },
      );
}

class LogoutCallBack extends StatelessWidget {
  const LogoutCallBack({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.logoutState != current.logoutState,
        listener: (context, state) => state.logoutState == Status.success
            ? Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.loginScreen, (route) => false)
            : null,
        buildWhen: (previous, current) =>
            previous.logoutState != current.logoutState,
        builder: (context, state) {
          switch (state.logoutState) {
            case Status.initial || Status.success:
              return const SizedBox();
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.error:
              return AppErrorMsg(error: state.errorType);
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
          }
        },
      );
}

class ConfirmCodeCallBack extends StatelessWidget {
  const ConfirmCodeCallBack({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.confirmCodeState != current.confirmCodeState,
        listener: (context, state) => state.confirmCodeState == Status.success
            ? Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.loginScreen, (route) => false)
            : null,
        buildWhen: (previous, current) =>
            previous.confirmCodeState != current.confirmCodeState,
        builder: (context, state) {
          switch (state.confirmCodeState) {
            case Status.initial || Status.success:
              return const SizedBox();
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.error:
              return AppErrorMsg(error: state.errorType);
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
          }
        },
      );
}

class ConfirmEmailCallBack extends StatelessWidget {
  const ConfirmEmailCallBack({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.confirmEmailState != current.confirmEmailState,
        listener: (context, state) => state.confirmEmailState == Status.success
            ? showDialog(
                context: context,
                builder: (context) => ResetPasswordDialog(email: email),
              )
            : null,
        buildWhen: (previous, current) =>
            previous.confirmEmailState != current.confirmEmailState,
        builder: (context, state) {
          switch (state.confirmEmailState) {
            case Status.initial || Status.success:
              return const SizedBox();
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.error:
              return AppErrorMsg(error: state.errorType);
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
          }
        },
      );
}

class ForgetPasswordCallback extends StatelessWidget {
  const ForgetPasswordCallback({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.forgetPasswordState != current.forgetPasswordState,
        listener: (context, state) =>
            state.forgetPasswordState == Status.success
                ? showDialog(
                    context: context,
                    builder: (context) => ConfirmEmailDialog(email: email),
                  )
                : null,
        buildWhen: (previous, current) =>
            previous.forgetPasswordState != current.forgetPasswordState,
        builder: (context, state) {
          switch (state.forgetPasswordState) {
            case Status.initial || Status.success:
              return const SizedBox();
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.error:
              return AppErrorMsg(error: state.errorType);
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
          }
        },
      );
}

class ResetPasswordCallback extends StatelessWidget {
  const ResetPasswordCallback({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.resetPasswordState != current.resetPasswordState,
        listener: (context, state) => state.resetPasswordState == Status.success
            ? Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.loginScreen, (route) => false)
            : null,
        buildWhen: (previous, current) =>
            previous.resetPasswordState != current.resetPasswordState,
        builder: (context, state) {
          switch (state.resetPasswordState) {
            case Status.initial || Status.success:
              return const SizedBox();
            case Status.loading:
              return const AppLoadingIndicator();
            case Status.error:
              return AppErrorMsg(error: state.errorType);
            case Status.failure:
              return AppFailureMsg(failure: state.msg);
          }
        },
      );
}
