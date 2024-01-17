import 'package:flutter/material.dart';
import '../../../../core/validation/input_validation.dart';

Widget passwordField({
  required TextEditingController controller,
  String? hint,
  bool isConfirm = false,
  TextEditingController? password,
}) {
  bool isVisible = true;
  return StatefulBuilder(builder: (context, setState) {
    return TextFormField(
      controller: controller,
      obscureText: isVisible,
      validator: (value) => isConfirm
          ? InputValidation.confirmPasswordValidation(value, password!.text)
          : InputValidation.passwordValidation(value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        hintText: hint,
        suffixIcon: InkWell(
          onTap: () => setState(() => isVisible = !isVisible),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: Icon(
              isVisible
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
            ),
          ),
        ),
      ),
    );
  });
}
