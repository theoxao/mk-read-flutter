import 'package:flutter/material.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/widgets/group_widget.dart';
import 'package:flutter_mk/widgets/mine_widget.dart';
import 'package:flutter_mk/widgets/shelf_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<HomePage> {
  var index = 0;

  static const _options = const <Widget>[
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
    return Scaffold(
      body: Center(
        child: _options.elementAt(index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: defaultItems,
        currentIndex: index,
        fixedColor: primaryColor,
        onTap: (value) {
          this.setState(() {
            this.index = value;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
