import 'dart:convert';

class FriendModel {
  final String name;
  final String image;
  final String id;

  FriendModel({
    required this.name,
    required this.image,
    required this.id,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'image': image,
        'id': id,
      };

  factory FriendModel.fromMap(Map<String, dynamic> map) => FriendModel(
        name: map['name'] as String,
        image: map['image'] as String,
        id: map['id'] as String,
      );

  String toJson() => json.encode(toMap());

  factory FriendModel.fromJson(String source) =>
      FriendModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
