class MapPointModel {
  final List<double> point;
  final List<String> ids;

  MapPointModel({
    required this.point,
    required this.ids,
  });

  factory MapPointModel.fromMap(List map) => MapPointModel(
        point: List.from(map[0] as List),
        ids: List.from(map[2] as List),
      );
}
