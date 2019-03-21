import 'package:flutter_mk/blocs/base_bloc.dart';
import 'package:flutter_mk/models/stat_models.dart';
import 'package:flutter_mk/repositories/statistic_repository.dart';

class StatBloc extends BaseBloc<List<Coordinate>> {
  String refBook;
  int type = StatType.DATE.index;
  int source = StatSource.TIME.index;

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
    var list = await StatRepository(context)
        .fetchStat(type, source, refBook: refBook);
    this.dataList = list;
    print(list.toString());
    sink.add(list);
  }

  void changeType(int type) async {
    this.type = type;
    initData(this.refBook);
  }

  void changeSource(int source) {
    this.source = source;
    initData(this.refBook);
  }
}

enum StatType { DATE, PERIOD }
enum StatSource { TIME, PAGE }
