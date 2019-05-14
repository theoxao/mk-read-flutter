import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/helper/ensure_visiable_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_mk/repositories/group_repository.dart';

class AddGroupPage extends StatefulWidget {
  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  final nameNode = FocusNode();
  final descNode = FocusNode();
  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("创建小组"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Card(
                child: Text("lalal"),
              ),
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
                                  getImage(ImageSource.camera);
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
                                  getImage(ImageSource.gallery);
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
            ),
            EnsureVisibleWhenFocused(
              focusNode: nameNode,
              child: Card(
                child: TextField(
                  controller: nameCtrl,
                  focusNode: nameNode,
                  decoration: InputDecoration(
                      labelText: "小组名",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none))),
                ),
              ),
            ),
            EnsureVisibleWhenFocused(
              focusNode: descNode,
              child: Card(
                child: TextField(
                  controller: descCtrl,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  focusNode: descNode,
                  decoration: InputDecoration(
                      labelText: "小组简介",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none))),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
				var body = Map<String, String>();
				body["name"] = nameCtrl.text;
				body["remark"] = descCtrl.text;
				GroupRepository(context).create( nameCtrl.text ,descCtrl.text ,_image  ).then((group){
					 Navigator.of(context).pop(context);
				});

			  },
              child: Text("创建小组"),
            )
          ],
        ),
      ),
    );
  }

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    setState(() {
      _image = image;
    });
  }
}
