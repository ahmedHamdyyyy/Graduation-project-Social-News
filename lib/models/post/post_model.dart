import 'package:equatable/equatable.dart';
import '../../config/constants/app_constants/constants.dart';
import 'post_converter.dart';

class PostModel extends Equatable {
  final String id;
  final String userId;
  final String userImage;
  final String desc;
  final String img;
  final String name;
  final String date;
  final double lat;
  final double long;
  final bool isLiked;
  final Filter filter;
  final int likes;
  final int comments;

  const PostModel({
    required this.userId,
    required this.userImage,
    required this.desc,
    required this.img,
    required this.lat,
    required this.long,
    required this.date,
    required this.isLiked,
    required this.filter,
    required this.likes,
    required this.name,
    required this.id,
    required this.comments,
  });

  static const non = PostModel(
    userId: '',
    userImage: '',
    desc: '',
    img: '',
    lat: 0,
    long: 0,
    date: '',
    isLiked: false,
    filter: Filter.non,
    likes: 0,
    comments: 0,
    name: '',
    id: '',
  );

  static PostModel fromConverter(PostConverter converter) => PostModel(
        date: converter.date,
        userId: converter.user.userId,
        userImage: converter.user.userImage,
        id: converter.id,
        img: converter.img,
        likes: converter.likes.length,
        isLiked: converter.likes.contains(profileData.id),
        filter: fit(converter.filter),
        desc: converter.desc,
        name: converter.user.name,
        lat: converter.coordinates.last,
        long: converter.coordinates.first,
        comments: converter.comments,
      );

  @override
  List<Object?> get props => [
        userId,
        id,
        desc,
        date,
        userImage,
        img,
        likes,
        name,
        lat,
        long,
        isLiked,
        filter,
        comments,
      ];

  PostModel update({
    String? userId,
    String? userImage,
    String? desc,
    String? img,
    String? name,
    String? date,
    bool? isLiked,
    Filter? filter,
    int? likes,
    int? comments,
    double? lat,
    double? long,
    String? id,
  }) =>
      PostModel(
        userId: userId ?? this.userId,
        userImage: userImage ?? this.userImage,
        desc: desc ?? this.desc,
        img: img ?? this.img,
        name: name ?? this.name,
        date: date ?? this.date,
        isLiked: isLiked ?? this.isLiked,
        filter: filter ?? this.filter,
        likes: likes ?? this.likes,
        comments: comments ?? this.comments,
        id: id ?? this.id,
        lat: lat ?? this.lat,
        long: long ?? this.long,
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'desc': desc,
        'img': img,
        'date': date,
        'location': {
          'type': 'Point',
          'coordinates': [lat, long]
        }
      };

  static Filter fit(String category) {
    switch (category) {
      case 'World':
        return Filter.world;
      case 'Business':
        return Filter.business;
      case 'Sci/Tech':
        return Filter.science;
      case 'sport':
        return Filter.sports;
      default:
        return Filter.world;
    }
  }
}
