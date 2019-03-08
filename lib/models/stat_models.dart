class Coordinate {
  String x;
  int y;

  Coordinate.fromJsonMap(Map<String, dynamic> map)
      : x = map["x"],
        y = map["y"];
}
