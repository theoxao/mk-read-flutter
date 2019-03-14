import 'package:flutter_mk/blocs/base_bloc.dart';
import 'package:flutter_mk/models/shelf_models.dart';
import 'package:flutter_mk/models/user_book.dart';
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

class ShelfBookBloc extends BaseBloc<List<UserBook>> {
	
	List<UserBook> list ;

	ShelfBookBloc(String tag){
		initData(tag);
	}

	void initData(String tag) async{
		var list = await ReadRepository(context).fetchShelfBook(tag);
		this.list = list;
		sink.add(list);
	}

	void refresh(String tag){
		initData(tag);
	}

}