import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mk/pages/read/search_book_page.dart';
import 'package:platform/platform.dart';
import 'common/commons.dart';
import 'package:flutter_mk/pages/read/add_book_page.dart';
import 'package:flutter_mk/pages/read/home_page.dart';
import 'package:fluwx/fluwx.dart' as wx;

final Platform platform = const LocalPlatform();

void main() {
//  if (platform.isAndroid)
//    UMengAnalytics.init('5bf8bed4f1f55696fc000403',
//        policy: Policy.BATCH, encrypt: true, reportCrash: false);
//  else if (platform.isIOS)
//    UMengAnalytics.init('5c3d942cf1f556b87c0010ab',
//        policy: Policy.BATCH, encrypt: true, reportCrash: false);
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  final home = HomePage();

  @override
  void initState() {
    super.initState();
    _initFluwx();
  }

  void _initFluwx() async {
    await wx.register(
        appId: "wxc79d3cbef456e552",
        doOnAndroid: true,
        doOnIOS: true,
        enableMTA: false);
    var result = await wx.isWeChatInstalled();
    print("wechat installed $result");
  }

  @override
  void dispose() {
    super.dispose();
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
      home: home,
      routes: <String, WidgetBuilder>{
//        "/": (context) => HomePage(),
        "/add_book": (context) => AddBookPage(),
        "/search_book": (context) => SearchBookPage(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('cn', 'ZH'),
      ],
    );
  }
}
