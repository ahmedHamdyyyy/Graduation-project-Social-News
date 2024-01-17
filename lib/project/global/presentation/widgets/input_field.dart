import 'package:flutter/material.dart';

Widget inputField({
  required TextEditingController controller,
  required String? Function(String?) validate,
  String? hint,
}) =>
    TextFormField(
      controller: controller,
      validator: validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        hintText: hint,
      ),
    );
