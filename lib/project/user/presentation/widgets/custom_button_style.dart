import 'package:flutter/material.dart';

ButtonStyle customButtonStyle({
  double padding = 8,
  double left = 0,
  double right = 0,
}) =>
    ButtonStyle(
      overlayColor:
          const MaterialStatePropertyAll(Color.fromARGB(255, 113, 75, 184)),
      backgroundColor:
          const MaterialStatePropertyAll(Color.fromARGB(255, 75, 47, 128)),
      padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: padding, vertical: 0)),
      iconSize: const MaterialStatePropertyAll(18),
      textStyle: const MaterialStatePropertyAll(TextStyle(fontSize: 16)),
      elevation: const MaterialStatePropertyAll(5),
      foregroundColor: const MaterialStatePropertyAll(Colors.white),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(right),
            left: Radius.circular(left),
          ),
        ),
      ),
    );
