import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/read/shlef_bloc.dart';
import 'package:flutter_mk/models/shelf_models.dart';
import 'package:flutter_mk/pages/read/tag_manage_page.dart';
import 'package:flutter_mk/views/read/shelf_book_view.dart';
import '../models/user_book.dart';
import 'package:flutter_umeng_analytics_fork/flutter_umeng_analytics_fork.dart';

class ShelfWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShelfState();
}

class ShelfState extends State<ShelfWidget>
    with SingleTickerProviderStateMixin {
  TagListBloc tagListBloc = TagListBloc();
  List<UserBook> books = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    tagListBloc.bindContext(context);
    UMengAnalytics.beginPageView("shelf");
  }

  Widget getByTag(String tag) {
    ShelfBookBloc shelfBookBloc = ShelfBookBloc(tag);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: StreamBuilder<List<UserBook>>(
        stream: shelfBookBloc.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            List<Widget> list = [];
            for (var value in snapshot.data) {
              list.add(GridTile(child: ShelfBookView(value)));
            }
            return GridView.custom(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
//                    crossAxisSpacing: padding16
              ),
              childrenDelegate: SliverChildListDelegate(list),
              controller: ScrollController(keepScrollOffset: false),
            );
          }
          ;
          return Text("");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Tag>>(
      stream: tagListBloc.stream,
      builder: (context, AsyncSnapshot<List<Tag>> snapshot) {
        if (snapshot.hasData) {
          List<Tag> tabs = snapshot.data;
          _tabController = TabController(length: tabs.length, vsync: this);
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.black,
                        tabs: tabs.map((s) {
                          return Tab(
                            text: s.tag,
                          );
                        }).toList()),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return TagManagePage();
                      }));
                    },
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            body: TabBarView(
                controller: _tabController,
                children: tabs.map((s) {
                  return getByTag(s.tag);
                }).toList()),
            floatingActionButton: FloatingActionButton(
              onPressed: fabPressed,
              child: Icon(Icons.add),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
    UMengAnalytics.endPageView("shelf");
  }

  void fabPressed() {
    Navigator.pushNamed(context, "/add_book");
  }
}
