import 'package:flutter/material.dart';
import 'package:flutter_mk/common/commons.dart';

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
        _tabController.addListener((){
            if(_tabController.previousIndex !=0){
                this.setState((){pageView= getPostList(widget.id);});
            }else
                this.setState((){pageView= getActivity(widget.id);});
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
                                          labelStyle: TextStyle(color: primaryColor , fontSize: 18),
                                          labelColor: primaryColor,
                                          unselectedLabelColor: Colors.red,
                                          indicatorColor: Colors.white,
                                          controller: _tabController,
                                          tabs: tabs,
                                      ),
                                  ),
                                  RaisedButton(child: Text("新发言"), onPressed: () {
                                  },)
                              ],
                          ),
                          Divider(),
                          Container(
                              child:pageView,
                          )
                      ],
                  ),
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
