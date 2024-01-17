import 'dart:convert';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String birthDate;
  final String details;
  final String study;
  final bool isFollowersViewed;
  final bool isActive;
  final bool isFollowingsViewed;
  final bool isProfileDataViewed;
  final List followers;
  final List followings;

  static const non = UserModel(
    id: '',
    name: '',
    email: '',
    phone: '',
    image: '',
    study: '',
    details: '',
    isFollowersViewed: true,
    isActive: true,
    isFollowingsViewed: true,
    isProfileDataViewed: true,
    birthDate: '2001-01-01 00:00:00.0',
    followers: [],
    followings: [],
  );

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.birthDate,
    required this.followers,
    required this.followings,
    required this.study,
    required this.details,
    required this.isFollowersViewed,
    required this.isActive,
    required this.isFollowingsViewed,
    required this.isProfileDataViewed,
  });

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
        'dateOfBirth': birthDate,
        'followers': followers,
        'followings': followings,
        'study': study,
        'details': details,
        'isFollowersViewed': isFollowersViewed,
        'is_active': isActive,
        'isFollowingsViewed': isFollowingsViewed,
        'isProfileDataViewed': isProfileDataViewed,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['_id'],
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        phone: map['phone'].toString(),
        birthDate: map['dateOfBirth'] ?? DateTime.now().toString(),
        image: map['image'] ?? '',
        followers: map['followers'] ?? [],
        followings: map['followings'] ?? [],
        study: map['study'] ?? '',
        details: map['caption'] ?? '',
        isFollowersViewed: map['isFollowersViewed'] ?? false,
        isActive: map['is_active'] ?? false,
        isFollowingsViewed: map['isFollowingsViewed'] ?? false,
        isProfileDataViewed: map['isProfileDataViewed'] ?? false,
      );

  Map<String, dynamic> register(String password) => {
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
        'password': password,
        'dateOfBirth': birthDate,
        'study': study,
        'details': details,
        'isActive': isActive,
        'isFollowersViewed': isFollowersViewed,
        'isFollowingsViewed': isFollowingsViewed,
        'isProfileDataViewed': isProfileDataViewed,
      };

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [
        id,
        name,
        email,
        phone,
        image,
        birthDate,
        followers,
        followings,
        study,
        details,
        isFollowersViewed,
        isActive,
        isFollowingsViewed,
        isProfileDataViewed,
      ];
}
