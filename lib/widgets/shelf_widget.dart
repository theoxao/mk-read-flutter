import 'package:flutter/material.dart';
import 'package:flutter_mk/repositories/read_repository.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../views/shelf_book_view.dart';
import '../models/user_book.dart';
import 'package:flutter_umeng_analytics_fork/flutter_umeng_analytics_fork.dart';

class ShelfWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShelfState();
}

class ShelfState extends State<ShelfWidget>
    with SingleTickerProviderStateMixin {
  List<String> tabs = <String>[
    "全部",
    "工具",
    "课外书",
    "其他",
    "未知",
    "测试",
  ];

  TabController _tabController;
  List<UserBook> books = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    UMengAnalytics.beginPageView("shelf");
  }

  Widget getByTag(String tag) {
    return FutureBuilder<List<UserBook>>(
      future: fetchShelfBook(tag),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        if (snapshot.hasData) {
          List<Widget> list = [];
          for (var value in snapshot.data) {
            list.add(GridTile(child: ShelfBookView(value)));
          }
          return LiquidPullToRefresh(
            showChildOpacityTransition: false,
            height: 80,
            springAnimationDurationInMilliseconds: 600,
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 0.75,
              controller: ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: list,
            ),
            onRefresh: () async {
              var data = fetchShelfBook(tag);
              await data.then((value) {
                this.setState(() {
                  this.books = value;
                });
              });
            },
          );
        }
        ;
        return Text("");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      text: s,
                    );
                  }).toList()),
            ),
            Center(
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: tabs.map((s) {
            return getByTag(s);
          }).toList()),
      floatingActionButton: FloatingActionButton(onPressed: fabPressed),
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
