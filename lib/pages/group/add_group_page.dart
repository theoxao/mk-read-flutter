import 'dart:async';

import 'package:flutter/material.dart';

//import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class AddGroupPage extends StatefulWidget {
  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("创建小组"),
      ),
      body: Builder(
        builder: (BuildContext context) {
//          return WebView(
//            initialUrl: "http://res.theoxao.com/mk-web/add_group.html",
//            javascriptMode: JavascriptMode.unrestricted,
//            onWebViewCreated: (WebViewController webViewController) {
//              _controller.complete(webViewController);
//            },
//          );
          return WebviewScaffold(
            url: "http://res.theoxao.com/mk-web/add_group.html",
          );
        },
      ),
    );
  }
}
