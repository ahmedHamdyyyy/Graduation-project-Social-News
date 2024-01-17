import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../posts/logic/posts_cubit.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      buildWhen: (previous, current) => previous.img != current.img,
      builder: (context, state) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 444, minHeight: 0),
        child: state.img == ''
            ? const SizedBox()
            : SizedBox(
                width: double.infinity,
                child: Image.memory(base64Decode(state.img), fit: BoxFit.cover),
              ),
      ),
    );
  }
}
