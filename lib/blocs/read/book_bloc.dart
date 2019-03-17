
import 'package:flutter_mk/blocs/base_bloc.dart';
import 'package:flutter_mk/models/book.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/repositories/read_repository.dart';

class BookSearchBloc extends BaseBloc<List<Book>>{
  BookSearchBloc(String barCode);

  void initData(String barCode) async{
    var books = await ReadRepository(context).fetchBookByIsbn(barCode);
    sink.add(books);
  }
}

class SelectedBookBLoc extends BaseBloc<UserBook>{
  UserBook book =UserBook();

  SelectedBookBLoc(){
    sink.add(book);
  }
}