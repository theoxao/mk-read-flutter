import 'package:flutter_mk/blocs/base_bloc.dart';
import 'package:flutter_mk/models/stat_models.dart';
import 'package:flutter_mk/repositories/statistic_repository.dart';

class StatBloc extends BaseBloc<List<Coordinate>> {
  static final StatBloc bloc = StatBloc._internal();

  StatBloc._internal() {
    sink.add(List());
    initData();
  }

  factory StatBloc() {
    return bloc;
  }

  List<Coordinate> dataList = List();

  void initData() async {
    var list = await StatRepository(context).fetchStat();
    this.dataList = list;
    sink.add(list);
  }
}
