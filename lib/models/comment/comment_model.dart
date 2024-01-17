// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../config/constants/app_constants/constants.dart';
import 'comment_converter_model.dart';

class CommentModel extends Equatable {
  final String id;
  final String userId;
  final String postId;
  final String userImage;
  final String desc;
  final String name;
  final String date;
  // final String image;
  final bool isLiked;
  final int likes;

  const CommentModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.userImage,
    required this.desc,
    required this.name,
    required this.date,
    // required this.image,
    required this.isLiked,
    required this.likes,
  });

  Map<String, dynamic> toMap() => {
        // 'id': id,
        'userId': userId,
        'postId': postId,
        'desc': desc,
        'date': date,
        'name': name,
        // 'image': image,
      };

  factory CommentModel.fromMap(Map<String, dynamic> map) => CommentModel(
        userId: map['userId'],
        userImage: map['userImage'],
        postId: map['postId'] as String,
        id: map['_id'] as String,
        name: map['name'] as String,
        desc: map['desc'] as String,
        date: map['date'] as String,
        // image: map['image'] as String,
        likes: map['likes'] as int,
        isLiked: false,
      );

  factory CommentModel.fromConverter(CommentConverter converter) =>
      CommentModel(
        userId: converter.user.userId,
        userImage: converter.user.userImage,
        postId: converter.postId,
        id: converter.id,
        name: converter.user.name,
        desc: converter.desc,
        date: converter.date,
        // image: converter.image,
        likes: converter.likes.length,
        isLiked: converter.likes.contains(profileData.id), //default value
      );

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [
        id,
        userId,
        postId,
        userImage,
        desc,
        name,
        date,
        // image,
        isLiked,
        likes,
      ];

  CommentModel update({
    String? id,
    String? userId,
    String? postId,
    String? userImage,
    String? desc,
    String? name,
    String? date,
    // String? image,
    bool? isLiked,
    int? likes,
  }) =>
      CommentModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        postId: postId ?? this.postId,
        userImage: userImage ?? this.userImage,
        desc: desc ?? this.desc,
        name: name ?? this.name,
        date: date ?? this.date,
        // image: image ?? this.image,
        isLiked: isLiked ?? this.isLiked,
        likes: likes ?? this.likes,
      );
}
