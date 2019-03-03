import 'package:flutter/material.dart';

class GroupDetailWidget extends StatefulWidget {
  final String id;

  GroupDetailWidget(this.id);

  @override
  _GroupDetailWidgetState createState() => _GroupDetailWidgetState();
}

class _GroupDetailWidgetState extends State<GroupDetailWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = List();
    tabs.add(Tab(
//      icon: Icon(Icons.rss_feed),
//      text: "小组发言",
      child: Text(
        "小组发言",
        style: TextStyle(color: Colors.black87),
      ),
    ));
    tabs.add(Tab(
//      icon: Icon(Icons.subscriptions),
      child: Text("小组动态", style: TextStyle(color: Colors.black87)),
    ));

    return Card(
      child: Container(
        height: 1000,
        child: Column(
          children: <Widget>[
            TabBar(
              tabs: tabs,
              controller: _tabController,
            ),
          ],
        ),
      ),
    );
  }

  Widget getPostList(String id) {
    return Text("posts");
  }

  Widget getActivity(String id) {
    return Text("activity");
  }
}
