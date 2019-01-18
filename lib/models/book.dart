class Book {
  String id;
  String name;
  String author;
  String introduction;
  String isbn;
  String pageCount;
  String publisher;
  String cover;
  int state;

  Book.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        author = map["author"],
        introduction = map["introduction"],
        isbn = map["isbn"],
        pageCount = map["pageCount"],
        publisher = map["publisher"],
        cover = map["cover"],
        state = map["state"];
}
