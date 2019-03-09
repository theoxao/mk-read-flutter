import 'package:flutter_mk/blocs/base_bloc.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/repositories/read_repository.dart';

class UserBookDetailBloc extends BaseBloc<UserBook> {

  UserBookDetailBloc(this.id){
    initData(id);
  }

  String id ;
  UserBook userBook;

  void initData(String id ) async {
    var userBook = await ReadRepository(context).fetchBookDetail(id);
    this.userBook = userBook;
    sink.add(userBook);
  }
}
