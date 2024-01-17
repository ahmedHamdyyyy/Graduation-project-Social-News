import 'package:flutter/material.dart';

class PostDescription extends StatefulWidget {
  const PostDescription({super.key, required this.desc});
  final String desc;

  @override
  State<PostDescription> createState() => _PostDescriptionState();
}

class _PostDescriptionState extends State<PostDescription> {
  bool _isLong = true;
  @override
  Widget build(BuildContext context) => widget.desc.length >= 350
      ? InkWell(
          onTap: () => setState(() => _isLong = !_isLong),
          child: Text(
            _isLong
                ? '${widget.desc.substring(0, 350)}...more'
                : '${widget.desc}... less',
          ),
        )
      : Text(widget.desc);
}
