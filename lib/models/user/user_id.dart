import 'dart:convert';

class UserId {
  final String userId;
  final String userImage;
  final String name;
  UserId({
    required this.userId,
    required this.name,
    required this.userImage,
  });

  factory UserId.fromMap(Map<String, dynamic> map) => UserId(
        userId: map['_id'] as String,
        name: map['name'] as String,
        userImage: map['image'] ?? '',
      );

  factory UserId.fromJson(String source) =>
      UserId.fromMap(json.decode(source) as Map<String, dynamic>);
}
