import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_umeng_analytics_fork/flutter_umeng_analytics_fork.dart';
import 'package:redux/redux.dart';

import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/widgets/group_widget.dart';
import 'package:flutter_mk/widgets/mine_widget.dart';
import 'package:flutter_mk/widgets/shelf_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

int switchIndex(int state, dynamic action) {
  return state = action;
}

class HomeState extends State<HomePage> {
  final indexStore = Store<int>(switchIndex, initialState: 0);

  final _options = <Widget>[
    ShelfWidget(),
    GroupListWidget(),
    MineWidget(),
  ];

  static const List<BottomNavigationBarItem> defaultItems =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.book), title: Text("书架")),
    BottomNavigationBarItem(icon: Icon(Icons.group), title: Text("小组")),
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("我的"))
  ];

  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
        store: indexStore,
        child:StoreConnector<int,int>(builder: (context , index){
          return Scaffold(
            body: Center(
              child: _options.elementAt(index),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: defaultItems,
              currentIndex: index,
              fixedColor: primaryColor,
              onTap: (value) {
                indexStore.dispatch(value);
              },
            ),
          );
        }, converter: (store)=>store.state)
    );
  }

  @override
  void initState() {
    super.initState();
    UMengAnalytics.beginPageView("home");
  }

  @override
  void dispose() {
    super.dispose();
    UMengAnalytics.endPageView("home");
  }
}
