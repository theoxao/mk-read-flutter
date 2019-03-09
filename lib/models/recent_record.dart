
class RecentRecord {

  String refBook;
  int startAt;
  Object endAt;
  int status;
  int duration;
  int currentPage;

  RecentRecord.fromJsonMap(Map<String, dynamic> map): 
    refBook = map["refBook"],
    startAt = map["startAt"],
    endAt = map["endAt"],
    status = map["status"],
    duration = map["duration"],
    currentPage = map["currentPage"];

}
