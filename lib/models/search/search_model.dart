class SearchModel {
  final String id;
  final String title;
  final String image;

  SearchModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory SearchModel.fromUser(Map<String, dynamic> map) => SearchModel(
        id: map['_id'] as String,
        title: map['name'] as String,
        image: map['image'] ?? '',
      );
  factory SearchModel.fromPost(Map<String, dynamic> map) => SearchModel(
        id: map['_id'] as String,
        title: map['desc'] as String,
        image: map['img'] ?? '',
      );
}
