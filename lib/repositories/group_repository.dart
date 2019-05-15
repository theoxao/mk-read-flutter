import 'dart:io' as prefix0;
import 'dart:io';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/models/group_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mk/http/request_wrap.dart';
import 'package:flutter_mk/models/post_model.dart';

class GroupRepository {
  EventRequest request;

  GroupRepository(BuildContext context) : request = EventRequest(context);

  Future<Group> create(String name, String remark, File imageFile) async {
    print("creating group");
    String path = host + "/group/group/create";
    FormData formData = new FormData.from({
      "name": name,
      "remark": remark,
      "imageFile": new UploadFileInfo(imageFile, imageFile.absolute.path),
    });
    var response = await request.post(getOption(path), data: formData);
    print(response);
    return Group.fromJsonMap(response.data['data']);
  }

  Future<List<Group>> fetchGroupList() async {
    print("requesting group list");
    String path = host + "/group/group/list";
    var response = await request.get(getOption(path));
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
    var response = await request.get(getOption(path));
    print(response);
    return Group.fromJsonMap(response.data["data"]);
  }

  Future<List<Post>> fetchPostList(String groupId) async {
    String path = "$host/group/post/list?id=$groupId";
    var response = await request.get(getOption(path));
    List<Post> list = [];
    for (var post in response.data["data"]) {
      list.add(Post.fromJsonMap(post));
    }
    return list;
  }

  Future<List<Activity>> fetchActivities(String groupId) async {
    String path = "$host/group/group/activity?groupId=$groupId";
    var response = await request.get(getOption(path));
    List<Activity> list = [];
    for (var act in response.data["data"]) {
      list.add(Activity.fromJson(act));
    }
    return list;
  }

  Future<Post> createPost(
      String groupId, String content, List<File> files) async {
    String path = "$host/group/post/post";

    var data = new FormData.from({
      "groupId": groupId,
      "content": content,
      "imageFiles":
          files.map((file) => UploadFileInfo(file, file.absolute.path)).toList()
    });
    print(data);
    var response = await request.post(getOption(path), data: data);
    print(response);
    return Post.fromJsonMap(response.data['data']);
  }

  Future<List<String>> likeOperate(String postId, int operate) async {
    String path =
        "$host/group/post/like_operate?postId=$postId&operate=$operate";
    var response = await request.post(getOption(path));
    List<String>list=[];
    for (var act in response.data["data"]) {
      list.add(act);
    }
    return list;
  }
}
