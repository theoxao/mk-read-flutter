class UserBook {
  String id;
  String refBookId;
  String userId;
  String name;
  String isbn;
  String cover;
  String author;
  String publisher;
  int pageCount;
  int returnDate;
  String remark;
  String tag;
  int state;
  int createAt;
  int updateAt;

  UserBook.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        refBookId = map["refBookId"],
        userId = map["userId"],
        name = map["name"],
        isbn = map["isbn"],
        cover = map["cover"],
        author = map["author"],
        publisher = map["publisher"],
        pageCount = map["pageCount"],
        returnDate = map["returnDate"],
        remark = map["remark"],
        tag = map["tag"],
        state = map["state"],
        createAt = map["createAt"],
        updateAt = map["updateAt"];
}
