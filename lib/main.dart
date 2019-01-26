import 'package:flutter/material.dart';
import 'package:flutter_mk/pages/read_page.dart';
import 'package:flutter_mk/pages/search_book_page.dart';
import 'package:flutter_umeng_analytics_fork/flutter_umeng_analytics_fork.dart';
import 'package:platform/platform.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'common/commons.dart';
import 'pages/add_book_page.dart';
import 'pages/home_page.dart';

final Platform platform = const LocalPlatform();

void main() {
  if (platform.isAndroid)
    UMengAnalytics.init('5bf8bed4f1f55696fc000403',
        policy: Policy.BATCH, encrypt: true, reportCrash: false);
  else if (platform.isIOS)
    UMengAnalytics.init('5c3d942cf1f556b87c0010ab',
        policy: Policy.BATCH, encrypt: true, reportCrash: false);
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    UMengAnalytics.beginPageView("init");
  }

  @override
  void dispose() {
    super.dispose();
    UMengAnalytics.endPageView("init");
  }

  ThemeData get theme {
    var i = DateTime.now().millisecond % 2;
    if (true) {
      return ThemeData(
          brightness: Brightness.light, primarySwatch: primaryColor);
    } else {
      return ThemeData(
          brightness: Brightness.dark, primarySwatch: primaryColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: HomePage(),
      routes: <String, WidgetBuilder>{
//        "/": (context) => HomePage(),
        "/add_book": (context) => AddBookPage(),
        "/search_book": (context) => SearchBookPage(),
      },
    );
  }
}
