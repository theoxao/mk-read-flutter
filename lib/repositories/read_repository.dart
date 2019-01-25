import 'package:dio/dio.dart';
import 'package:flutter_mk/models/book.dart';

import '../models/user_book.dart';
//part 'read_repository.g.dart';

final host = "http://www.theoxao.com:8888";

Options get getOptions {
  Map<String, dynamic> headers = Map();
  headers['token'] = "70843bc3-794a-4d99-a05a-c4e6487036bd";
  var _options = Options(headers: headers);
  return _options;
}

Future<List<UserBook>> fetchShelfBook(String tag) async {
  print("requesting tag is $tag");
  if (tag == "全部") tag = "";
  String path = host + "/read/shelf/list?tag=$tag";
  var response = await Dio(getOptions).get(path);
  var data = response.data['data'];
  List<UserBook> result = [];
  for (var value in data) {
    result.add(UserBook.fromJsonMap(value));
  }
  return result;
}

Future<List<Book>> fetchBookByIsbn(String isbn) async {
  print("requesting book is $isbn");
  String path = host + "/read/read/isbn/$isbn";
  var response = await Dio(getOptions).get(path);
  List<Book> result = [];
  for (var value in response.data['data']) {
    result.add(Book.fromJsonMap(value));
  }
  return result;
}


Future fetchReadStat(String id) async {
    print("requesting read stat");
    String path = host + "/read/read/read_stat?id=$id";
    var response = await Dio(getOptions).get(path);
    print(response.data);
    return response.data['data'];
}