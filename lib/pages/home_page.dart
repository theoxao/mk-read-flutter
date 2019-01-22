import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/home_bloc.dart';
import 'package:flutter_mk/models/home_model.dart';
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
  HomeBloc bloc;

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
    bloc = BlocProvider.of<HomeBloc>(context);
    return StreamBuilder(
      stream: bloc.stream,
      initialData: Home(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Home home = snapshot.data;
        return Scaffold(
          body: Center(child: _options.elementAt(home.currentIndex)),
          bottomNavigationBar: BottomNavigationBar(
            items: home.bottomItems,
            currentIndex: home.currentIndex,
            fixedColor: primaryColor,
            onTap: _navOnTap,
          ),
        );
      },
    );
  }

  _navOnTap(int index) {
    bloc.sink.add(Home(currentIndex: index));
  }
}
