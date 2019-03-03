import 'package:flutter_mk/models/group_models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_mk/repositories/group_repository.dart';

class GroupListBloc {
  static final GroupListBloc bloc = GroupListBloc._internal();

  GroupListBloc._internal() {
    initData();
  }

  factory GroupListBloc() {
//    initData();
    return bloc;
  }

  List<Group> groupList = List();

  final _subject = BehaviorSubject<List<Group>>.seeded(List());

  Stream<List<Group>> get stream => _subject.stream;

  Sink<List<Group>> get sink => _subject.sink;

  void close() {
    _subject.close();
  }

  void initData() async {
    var list = await fetchGroupList();
    this.groupList = list;
    sink.add(list);
  }
}

class GroupDetailBlocFactory {
  static final GroupDetailBlocFactory instance =
      GroupDetailBlocFactory._internal();

  GroupDetailBlocFactory._internal();

  factory GroupDetailBlocFactory() {
    return instance;
  }

  Map<String, GroupDetailBloc> blocCache = Map();

  GroupDetailBloc bloc(String id) {
    if (!blocCache.containsKey(id)) {
      blocCache[id] = GroupDetailBloc(id);
    }
    return blocCache[id];
  }
}

class GroupDetailBloc {
  Group currentGroup;

  GroupDetailBloc(String id) {
    initData(id);
  }

  final _subject = BehaviorSubject<Group>();

  Stream<Group> get stream => _subject.stream;

  Sink<Group> get sink => _subject.sink;

  void initData(String id) async {
    var group = await fetchGroupDetail(id);
    this.currentGroup = group;
    sink.add(group);
  }

  void close() {
    _subject.close();
  }
}
