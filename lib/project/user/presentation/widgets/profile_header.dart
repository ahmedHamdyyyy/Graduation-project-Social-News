import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../../../config/constants/app_constants/constants.dart';
import '../../../../models/user/user_model.dart';
import '../../../global/presentation/widgets/app_error_msg.dart';
import '../../../global/presentation/widgets/app_failure_msg.dart';
import '../../logic/user_cubit.dart';
import 'header_widget.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) =>
          previous.myData != current.myData ||
          previous.getMyDataState != current.getMyDataState,
      builder: (context, state) {
        switch (state.getMyDataState) {
          case Status.initial:
          case Status.loading:
            return const HeaderWidget(user: UserModel.non);
          case Status.failure:
            return AppFailureMsg(failure: state.msg);
          case Status.error:
            return AppErrorMsg(error: state.error);
          case Status.success:
            return HeaderWidget(user: state.myData);
        }
      },
    );
  }
}
