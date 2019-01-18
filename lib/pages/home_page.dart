import 'package:flutter/material.dart';
import 'package:flutter_umeng_analytics_fork/flutter_umeng_analytics_fork.dart';

import '../common/commons.dart';
import '../widgets/group_widget.dart';
import '../widgets/mine_widget.dart';
import '../widgets/shelf_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  int _selectedIndex = 0;
  final _options = <Widget>[
    ShelfWidget(),
    GroupWidget(),
    MineWidget(),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _options.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.book), title: Text("书架")),
          BottomNavigationBarItem(icon: Icon(Icons.group), title: Text("小组")),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("我的"))
        ],
        currentIndex: _selectedIndex,
        fixedColor: primaryColor,
        onTap: _navOnTap,
      ),
    );
  }

  _navOnTap(int index) {
    this.setState(() {
      _selectedIndex = index;
    });
  }
}
