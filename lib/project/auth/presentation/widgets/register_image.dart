// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../config/constants/app_constants/constants.dart';
import '../../logic/auth_cubit.dart';

Widget get registerImage => BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: state.image != ''
                    ? Image.memory(base64Decode(state.image),
                        height: 150, width: 150, fit: BoxFit.cover)
                    : Image.asset(logoImage,
                        fit: BoxFit.cover, height: 150, width: 150),
              ),
              const SizedBox(height: 20),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final imageFile = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                    imageQuality: 75,
                    maxHeight: 380,
                    maxWidth: 580,
                  );
                  if (imageFile != null) {
                    final file = await imageFile.readAsBytes();
                    context.read<AuthCubit>().pickImage(base64Encode(file));
                    if (kDebugMode) print(base64Encode(file).length);
                  }
                },
                clipBehavior: Clip.antiAliasWithSaveLayer,
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder()),
                ),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.camera_alt_rounded, size: 20),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 50, width: 30),
                  state.image != ''
                      ? ElevatedButton(
                          onPressed: () => context.read<AuthCubit>().clearImage,
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(CircleBorder()),
                          ),
                          child: const Icon(Icons.clear, size: 25),
                        )
                      : const SizedBox(),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  final imageFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 75,
                    maxHeight: 380,
                    maxWidth: 580,
                  );
                  if (imageFile != null) {
                    final file = await imageFile.readAsBytes();
                    context.read<AuthCubit>().pickImage(base64Encode(file));
                    if (kDebugMode) print(base64Encode(file).length);
                  }
                },
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(CircleBorder())),
                child: const Icon(Icons.photo_library_rounded, size: 25),
              ),
            ],
          ),
        ],
      ),
    );
