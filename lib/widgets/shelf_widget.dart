import 'package:flutter/material.dart';
import 'package:flutter_mk/repositories/read_repository.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:redux/redux.dart';
import '../views/shelf_book_view.dart';
import '../models/user_book.dart';
import 'package:flutter_umeng_analytics_fork/flutter_umeng_analytics_fork.dart';

class ShelfStateModel {
  List<String> tabs;

  List<UserBook> books = [];

  ShelfStateModel(
      {this.tabs = const [
        "全部",
        "工具",
        "课外书",
        "其他",
        "未知",
        "测试",
      ],
      this.books});
}

enum Actions { loadBooks, loadTags }

class ShelfWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShelfState();
}

ShelfStateModel shelfStateReducer(ShelfStateModel state, dynamic action) {
  return ShelfStateModel();
}

class ShelfState extends State<ShelfWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final shelfStore = Store<ShelfStateModel>(shelfStateReducer,
      initialState: ShelfStateModel());

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: tabs.length, vsync: this);
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
              onRefresh: () {});
        }
        ;
        return Text("");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<ShelfStateModel>(
      store: shelfStore,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: StoreConnector<ShelfStateModel, List<String>>(
                  builder: (context, tabs) {
                    return TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.black,
                        tabs: tabs.map((s) {
                          return Tab(
                            text: s,
                          );
                        }).toList());
                  },
                  converter: (store) => store.state.tabs,
                ),
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
        body: StoreConnector(
          builder: (context, tabs) {
            return TabBarView(
                controller: _tabController,
                children: tabs.map((s) {
                  return getByTag(s);
                }).toList());
          },
          converter: (store) => store.state.tabs,
        ),
        floatingActionButton: FloatingActionButton(onPressed: fabPressed),
      ),
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
