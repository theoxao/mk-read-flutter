class Tag {
  String id;
  String userId;
  String tag;
  int order;

  Tag.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        userId = map["userId"],
        tag = map["tag"],
        order = map["order"];
}
