import 'package:flutter_mk/blocs/base_bloc.dart';
import 'package:flutter_mk/models/book.dart';
import 'package:flutter_mk/models/read_detail_models.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/repositories/read_repository.dart';

class UserBookDetailBloc extends BaseBloc<UserBook> {
  UserBookDetailBloc(this.id) {
    initData(id);
  }

  String id;

  UserBook userBook;

  void initData(String id) async {
    var userBook = await ReadRepository(context).fetchBookDetail(id);
    this.userBook = userBook;
    sink.add(userBook);
  }
}

class ReadStatBloc extends BaseBloc<dynamic> {
  ReadStatBloc(String id) {
    initData(id);
  }

  void initData(String id) async {
    var data = await ReadRepository(context).fetchReadStat(id);
    sink.add(data);
  }
}

class ReadProgressBloc extends BaseBloc<List<ReadProgress>> {
  List<ReadProgress> list;

  ReadProgressBloc(String id, {String offsetId  , int size }) {
    initData(id, offsetId: offsetId, size: size);
  }

  void initData(String id, {String offsetId ="", int size = 0}) async {
    var list = await ReadRepository(context)
        .fetchReadProgress(id, offsetId: offsetId, size: size);
    print(list);
    sink.add(list);
  }

  void loadMore() {}
}
