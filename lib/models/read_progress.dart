class ReadProgress {
  String id;
  String userBookId;
  int startAt;
  int endAt;
  int status;
  int duration;
  int currentPage;

  ReadProgress.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        userBookId = map["userBookId"],
        startAt = map["startAt"],
        endAt = map["endAt"],
        status = map["status"],
        duration = map["duration"],
        currentPage = map["currentPage"];
}
