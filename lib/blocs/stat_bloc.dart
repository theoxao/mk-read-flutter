import 'package:flutter_mk/models/group_models.dart';
import 'package:flutter_mk/models/stat_models.dart';
import 'package:flutter_mk/repositories/statistic_repository.dart';
import 'package:rxdart/rxdart.dart';

class StatBloc {
    static final StatBloc bloc = StatBloc._internal();

    StatBloc._internal() {
        initData();
    }

    factory StatBloc() {
//    initData();
        return bloc;
    }

    List<Coordinate> dataList = List();

    final _subject = BehaviorSubject<List<Coordinate>>.seeded(List());

    Stream<List<Coordinate>> get stream => _subject.stream;

    Sink<List<Coordinate>> get sink => _subject.sink;

    void close() {
        _subject.close();
    }

    void initData() async {
        var list = await fetchStat();
        this.dataList = list;
        sink.add(list);
    }
}

