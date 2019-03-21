import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/group/post_bloc.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/models/post_model.dart';
import 'package:flutter_mk/pages/group/add_post.dart';
import 'package:flutter_mk/views/group/act_view.dart';
import 'package:flutter_mk/views/group/post_view.dart';

class GroupDetailWidget extends StatefulWidget {
  final String id;

  GroupDetailWidget(this.id);

  @override
  _GroupDetailWidgetState createState() => _GroupDetailWidgetState();
}

class _GroupDetailWidgetState extends State<GroupDetailWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Widget pageView;

  @override
  void initState() {
    pageView = getPostList(widget.id);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.previousIndex != 0) {
        this.setState(() {
          pageView = getPostList(widget.id);
        });
      } else
        this.setState(() {
          pageView = getActivity(widget.id);
        });
    });
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
      child: Text(
        "小组发言",
        style: TextStyle(color: Colors.black87),
      ),
    ));
    tabs.add(Tab(
      child: Text("小组动态", style: TextStyle(color: Colors.black87)),
    ));
    return Card(
      elevation: 6,
      child: Container(
        height: 1000,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TabBar(
                      labelStyle: TextStyle(color: primaryColor, fontSize: 18),
                      labelColor: primaryColor,
                      unselectedLabelColor: Colors.red,
                      indicatorColor: Colors.white,
                      controller: _tabController,
                      tabs: tabs,
                    ),
                  ),
                ],
              ),
              Divider(),
              Container(
                child: pageView,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getPostList(String id) {
    var bloc = PostBloc(id);

    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          var list = snapshot.data;
          return Column(
            children: list.map((post) {
              return PostView(post: post);
            }).toList(),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget getActivity(String id) {
    var bloc = ActivityBloc(id);
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, AsyncSnapshot<List<Activity>> snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          var list = snapshot.data;
          return Column(
            children: list.map((act) {
              return ActivityView(activity: act);
            }).toList(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
