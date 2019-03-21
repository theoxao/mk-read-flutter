import 'package:flutter_mk/blocs/base_bloc.dart';
import 'package:flutter_mk/models/post_model.dart';
import 'package:flutter_mk/repositories/group_repository.dart';

class PostBloc extends BaseBloc<List<Post>> {
  List<Post> list;
  String groupId;

  PostBloc(String groupId) {
    this.groupId = groupId;
    initData(groupId);
  }

  void initData(String groupId) async {
    var list = await GroupRepository(context).fetchPostList(groupId);
    this.list = list;
    sink.add(list);
  }
}

class ActivityBloc extends BaseBloc<List<Activity>> {
  List<Activity> list;

  String groupId;

  ActivityBloc(String groupId) {
    this.groupId = groupId;
  }

  void initData(String groupId) async{
      var list  = await GroupRepository(context).fetchActivities(groupId);
      this.list= list;
      sink.add(list);
  }
}
