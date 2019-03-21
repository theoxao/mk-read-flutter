
class Post {

  String id;
  String groupId;
  String userId;
  String nickName;
  String avatarUrl;
  String refBook;
  String refBookName;
  String content;
  List<String> images;
  int createAt;
  int updateAt;
  String timeDisplay;
  bool liked;
  List<String> likeList;
  List<Object> comments;

  Post.fromJsonMap(Map<String, dynamic> map): 
    id = map["id"],
    groupId = map["groupId"],
    userId = map["userId"],
    nickName = map["nickName"],
    avatarUrl = map["avatarUrl"],
    refBook = map["refBook"],
    refBookName = map["refBookName"],
    content = map["content"],
    images = List<String>.from(map["images"]),
    createAt = map["createAt"],
    updateAt = map["updateAt"],
    timeDisplay = map["timeDisplay"],
    liked = map["liked"],
    likeList = List<String>.from(map["likeList"]),
    comments = map["comments"];

}
