// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import '../user/user_id.dart';

class PostConverter {
  final String id;
  final UserId user;
  final String desc;
  final String date;
  final List likes;
  final List coordinates;
  final String img;
  final String filter;
  final int comments;

  PostConverter({
    required this.id,
    required this.user,
    required this.desc,
    required this.date,
    required this.coordinates,
    required this.likes,
    required this.img,
    required this.filter,
    required this.comments,
  });

  factory PostConverter.fromMap(Map<String, dynamic> map) => PostConverter(
        id: map['_id'] as String,
        user: UserId.fromMap(map['userId'] as Map<String, dynamic>),
        desc: map['desc'] as String,
        date: map['date'] ?? DateTime.now().toString(),
        likes: List.from((map['likes'] as List)),
        coordinates: List.from((map['location']['coordinates'] as List)),
        img: map['img'] ?? '',
        filter: map['category'] ?? '',
        comments: map['commentCount'] ?? 0,
      );

  factory PostConverter.fromJson(String source) =>
      PostConverter.fromMap(json.decode(source) as Map<String, dynamic>);
}
