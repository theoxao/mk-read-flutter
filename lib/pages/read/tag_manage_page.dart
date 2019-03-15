import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/read/shlef_bloc.dart';
import 'package:flutter_mk/models/shelf_models.dart';
import 'package:flutter_mk/repositories/read_repository.dart';

class TagManagePage extends StatelessWidget {
  final TagListBloc tagListBloc = TagListBloc();

  final RecommandTagBloc recommandTagBloc = RecommandTagBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分类管理"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: Border(),
                child: SizedBox(
                  width: 360,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Icon(Icons.widgets),
                          Text("我的分类")
                        ]),
                        Divider(),
                        StreamBuilder<List<Tag>>(
                          stream:tagListBloc.stream,
                          builder:
                              (context, AsyncSnapshot<List<Tag>> snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data);
                              var tags = snapshot.data;
                              List<Widget> list = [];
                              list.addAll(tags.map((it) {
                                var tag = it.tag;
                                return Chip(
                                  onDeleted: () {
                                    print("delete ${it.id}");
                                  },
                                  deleteIcon: Icon(Icons.remove_circle),
                                  deleteIconColor: Colors.red,
                                  label: Text(tag),
                                );
                              }).toList());
                              return Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: list,
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<List<String>>(
                    stream: recommandTagBloc.stream,
                    builder: (context, AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasData) {
                        var list = snapshot.data;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Icon(Icons.widgets),
                              Text("常用分类")
                            ]),
                            Divider(),
                            Wrap(
                              spacing: 8,
                              children: list.map((it) {
                                return Chip(label: Text(it));
                              }).toList(),
                            ),
                            Divider(),
                            RaisedButton(
                              onPressed: () {},
                              child: Text("自定义分类"),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
