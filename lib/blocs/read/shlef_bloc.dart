import 'package:flutter_mk/blocs/base_bloc.dart';
import 'package:flutter_mk/models/shelf_models.dart';
import 'package:flutter_mk/repositories/read_repository.dart';

class TagListBloc extends BaseBloc<List<Tag>> {
  List<Tag> tags;

  TagListBloc() {
    initData();
  }

  void initData() async {
    var list = await ReadRepository(context).fetchTagList();
    this.tags = list;
    sink.add(list);
  }
}
