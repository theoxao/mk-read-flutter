import 'package:flutter_mk/models/book.dart';
import 'package:flutter_mk/models/ref_book.dart';
import 'package:flutter_mk/models/recent_record.dart';

class UserBook {

  String id;
  String refBookId;
  String userId;
  String name;
  String isbn;
  String cover ="";
  String author;
  String publisher;
  int pageCount;
  Object returnDate;
  Object remark;
  String tag;
  int state;
  int createAt;
  int updateAt;
  RefBook refBook;
  RecentRecord recentRecord;


  UserBook();

  UserBook.fromJsonMap(Map<String, dynamic> map):
    id = map["id"],
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
    updateAt = map["updateAt"],
    refBook =map["refBook"] ==null?null: RefBook.fromJsonMap(map["refBook"]),
    recentRecord =map["recentRecord"]==null?null: RecentRecord.fromJsonMap(map["recentRecord"]);

}
