import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mk/common/commons.dart';

class NewPostPage extends StatefulWidget {
  final groupId;

  const NewPostPage({Key key, this.groupId}) : super(key: key);

  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  List<File> files = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = files.map<Widget>((file) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.file(
          file,
          fit: BoxFit.cover,
          width: coverWidth,
          height: coverWidth,
        ),
      );
    }).toList();
    rows.add(GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(64.0),
              child: Center(
                child: Container(
                  height: 100,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
//                          getImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          child: Center(
                            child: Text(
                              "拍照",
                              style: bookNameStyle,
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: () {
//                          getImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          child: Center(
                            child: Text(
                              "从相册选择",
                              style: bookNameStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Image.asset(
        "image/ic_add_cover.png",
        width: coverWidth,
        height: coverWidth,
      ),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text("新发言"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              child: Card(
                child: Column(
                  children: <Widget>[
                    TextFormField(),
                    Row(
                      children: rows,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

//  Future getImage(ImageSource source) async {
//    var image = await ImagePicker.pickImage(source: source);
//
//    setState(() {
//      files.add(image);
//    });
//  }
}
