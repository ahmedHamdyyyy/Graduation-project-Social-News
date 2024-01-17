import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/app_constants/colors.dart';
import '../../logic/auth_cubit.dart';
import '../widgets/register_body.dart';
import '../widgets/register_image.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>().initRegister;
    return Scaffold(
      appBar: AppBar(),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              registerImage,
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: foreGround[0],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 15, bottom: 5),
                  child: registerBody(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
