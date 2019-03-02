import 'package:flutter/material.dart';
import 'package:flutter_mk/common/commons.dart';

class SearchBookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<SearchBookPage> {
  List<DropdownMenuItem<int>> list = [];
  var _value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 10; i++) {
      list.add(
          DropdownMenuItem<int>(child: Text("item" + i.toString()), value: i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: null,
            title: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Expanded(
                    child: TextField(
                      style: TextStyle(color: colorWhite),
                      decoration: InputDecoration(
                          fillColor: colorWhite,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                    ),
                  ),
                )
              ],
            )));
  }
}
