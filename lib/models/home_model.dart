import 'package:flutter/material.dart';

class Home {
  int currentIndex;

  List<BottomNavigationBarItem> bottomItems;

  Home({this.currentIndex = 0, this.bottomItems = defaultItems});

  static const List<BottomNavigationBarItem> defaultItems =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.book), title: Text("书架")),
    BottomNavigationBarItem(icon: Icon(Icons.group), title: Text("小组")),
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("我的"))
  ];
}
