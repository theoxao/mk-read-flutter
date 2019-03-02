import 'package:dio/dio.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/models/group_models.dart';

Future<List<Group>> fetchGroupList() async {
  print("requesting group list");
  String path = host + "/group/group/list";
  var response = await Dio(getOptions).get(path);
  print(response);
  List<Group> list = [];
  for (var group in response.data['data']) {
    list.add(Group.fromJsonMap(group));
  }
  return list;
}

Future<Group> fetchGroupDetail(String id) async {
  print("request group detail");
  String path = host + "/group/group/detail?id=$id";
  var response = await Dio(getOptions).get(path);
  print(response);
  return Group.fromJsonMap(response.data["data"]);
}
