// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../user/user_id.dart';

class CommentConverter extends Equatable {
  final String id;
  final UserId user;
  final String postId;
  final String desc;
  final String date;
  // final String image;
  final List likes;

  const CommentConverter({
    required this.id,
    required this.user,
    required this.postId,
    required this.desc,
    required this.date,
    // required this.image,
    required this.likes,
  });

  factory CommentConverter.fromMap(Map<String, dynamic> map) =>
      CommentConverter(
        id: map['_id'] as String,
        user: UserId.fromMap(map['userId'] as Map<String, dynamic>),
        postId: map['postId'] as String,
        desc: map['desc'] as String,
        date: map['date'] as String,
        // image: map['image'] as String,
        likes: List.from((map['likes'] as List)),
      );

  factory CommentConverter.fromJson(String source) =>
      CommentConverter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [
        user,
        postId,
        desc,
        date,
        // image,
        likes,
      ];

  CommentConverter update({
    String? id,
    UserId? user,
    String? postId,
    String? desc,
    String? date,
    // String? image,
    List? likes,
  }) =>
      CommentConverter(
        id: id ?? this.id,
        user: user ?? this.user,
        postId: postId ?? this.postId,
        desc: desc ?? this.desc,
        date: date ?? this.date,
        // image: image ?? this.image,
        likes: likes ?? this.likes,
      );
}
