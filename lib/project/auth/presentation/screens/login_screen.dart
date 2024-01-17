import 'package:flutter/material.dart';
import '../../../../config/constants/app_constants/colors.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 55),
                Image.asset(logoImage, height: 222, width: 222),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 5),
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                    decoration: BoxDecoration(
                      color: foreGround[0],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child: loginBody(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
