import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as wx;
import 'package:fluwx/fluwx.dart';

class MineWidget extends StatefulWidget {
  const MineWidget();

  @override
  State<StatefulWidget> createState() => MineState();
}

class MineState extends State<MineWidget> {
  var code = "";

  @override
  void initState() {
    super.initState();
    wx.responseFromAuth.listen((data) {
      setState(() {
        this.code = data.toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("click me"),
            onPressed: () async {
             await wx.sendAuth(
                  scope: "snsapi_userinfo", state: "wechat_sdk_demo_test").then((data){
                print(data);
              });
            },
          ),
          Text(code)
        ],
      ),
    );
  }
}
