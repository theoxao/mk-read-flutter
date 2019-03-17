import 'package:flutter_mk/blocs/base_bloc.dart';
import 'package:flutter_mk/models/stat_models.dart';
import 'package:flutter_mk/repositories/statistic_repository.dart';

class StatBloc extends BaseBloc<List<Coordinate>> {
  String refBook;

  StatBloc._internal(refBook) {
    refBook = refBook;
    sink.add(List());
    initData(refBook);
  }

  factory StatBloc({String refBook}) {
    return StatBloc._internal(refBook);
  }

  List<Coordinate> dataList = List();

  void initData(String refBook) async {
    var list = await StatRepository(context).fetchStat("0", refBook: refBook);
    this.dataList = list;
    print(list.toString());
    sink.add(list);
  }

  void changeType(String type) async {
    var list = await StatRepository(context).fetchStat(type, refBook: refBook);
    this.dataList = list;
    sink.add(list);
  }
}
