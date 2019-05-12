import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddGroupPage extends StatefulWidget {
  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  String result = "创建小组";
  WebViewController _controller;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(result),
      ),
      body: WebView(
        initialUrl: "http://res.theoxao.com/mk-web/add_group.html",
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: <JavascriptChannel>[
          JavascriptChannel(
            onMessageReceived: (JavascriptMessage message) {
              setState(() {
                this.result = message.message;
              });
            },
            name: "Toast",
          ),
          JavascriptChannel(
            onMessageReceived: (JavascriptMessage focus){
              print(focus.message);
              if (focus.message == 'focus') {
                FocusScope.of(context)
                    .requestFocus(_focusNode);
              } else if (focus.message == 'focusout') {
                _focusNode.unfocus();
              }
            },
            name: "Focus",
          )
        ].toSet(),
        onWebViewCreated: (WebViewController controller) {
          this._controller = controller;
          controller.evaluateJavascript('''
              inputs = document.querySelectorAll("input[type=text]");
              inputs.forEach(function(inp) {
              let finalInput = inp;
              finalInput.addEventListener("focus", function() {
                  console.log('focus');
                  input = finalInput;
                  InputValue.postMessage('');
                  Focus.postMessage('focus');
             });
             finalInput.addEventListener("focusout", function() {
                 console.log('unfocus');
                 Focus.postMessage('focusout');
             });
             });  
            ''');
        },
      ),
    );
  }
}
