import 'package:dio/dio.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/models/group_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mk/http/request_wrap.dart';

class GroupRepository {
  EventRequest request;

  GroupRepository(BuildContext context) : request = EventRequest(context);

  Future<List<Group>> fetchGroupList() async {
    print("requesting group list");
    String path = host + "/group/group/list";
    var response = await request.get(getOptions);
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
}
