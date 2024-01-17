import 'package:equatable/equatable.dart';

class PostGenerated extends Equatable {
  final String id;
  final String postString;
  final List<String> postsIds;

  const PostGenerated({
    required this.id,
    required this.postString,
    required this.postsIds,
  });

  factory PostGenerated.fromMap(Map<String, dynamic> map) => PostGenerated(
        id: map['_id'],
        postString: map['postString'],
        postsIds: List.from(map['postsIds'] as List),
      );

  @override
  List<Object?> get props => [
        id,
        postString,
        postsIds,
      ];
}
