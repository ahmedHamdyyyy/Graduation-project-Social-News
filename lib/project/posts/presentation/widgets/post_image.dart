import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../config/constants/app_constants/constants.dart';

class PostImage extends StatelessWidget {
  const PostImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) => image.length <= 1000
      ? Image.asset(personImage, height: 50, width: 50, fit: BoxFit.fitHeight)
      : Image.memory(base64Decode(image), height: 50, width: 50, fit: BoxFit.cover);
}
