import 'package:flutter_mk/blocs/base_bloc.dart';
import 'package:flutter_mk/models/group_models.dart';
import 'package:flutter_mk/repositories/group_repository.dart';

class GroupListBloc extends BaseBloc<List<Group>> {
  static final GroupListBloc bloc = GroupListBloc._internal();

  GroupListBloc._internal() {
    sink.add(List());
    initData();
  }

  factory GroupListBloc() {
//    initData();
    return bloc;
  }

  List<Group> groupList = List();

  void initData() async {
    var list = await GroupRepository(context).fetchGroupList();
    this.groupList = list;
    sink.add(list);
  }
}

class GroupDetailBloc extends BaseBloc<Group> {
  Group currentGroup;

  GroupDetailBloc(String id) {
    initData(id);
  }

  void initData(String id) async {
    var group = await GroupRepository(context).fetchGroupDetail(id);
    this.currentGroup = group;
    sink.add(group);
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
