// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../config/constants/app_constants/colors.dart';
import '../../../posts/logic/posts_cubit.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => Container(
            padding: const EdgeInsets.all(10),
            height: 130,
            width: double.infinity,
            child: StatefulBuilder(
              builder: (context, setState) => Column(
                children: [
                  _themeButton(
                    context,
                    'Camera',
                    () async {
                      final imageFile = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        imageQuality: 75,
                        maxHeight: 380,
                        maxWidth: 580,
                      );
                      if (imageFile != null) {
                        final file = await imageFile.readAsBytes();
                        context
                            .read<PostsCubit>()
                            .pickImage(base64Encode(file));
                        if (kDebugMode) print(base64Encode(file).length);
                      }
                      Navigator.pop(context);
                    },
                  ),
                  _themeButton(
                    context,
                    'Gallery',
                    () async {
                      final imageFile = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 75,
                        maxHeight: 380,
                        maxWidth: 580,
                      );
                      if (imageFile != null) {
                        final file = await imageFile.readAsBytes();
                        context
                            .read<PostsCubit>()
                            .pickImage(base64Encode(file));
                        if (kDebugMode) print(base64Encode(file).length);
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      icon: const Icon(Icons.photo_camera_back_rounded),
    );
  }

  Widget _themeButton(
    BuildContext context,
    String text,
    void Function() onTap,
  ) =>
      Row(
        children: [
          Expanded(
            child: TextButton(
              style: _buttonStyle,
              onPressed: onTap,
              child: Text(text),
            ),
          ),
        ],
      );

  ButtonStyle get _buttonStyle =>
      ButtonStyle(backgroundColor: MaterialStatePropertyAll(secondaryColor[0]));
}
