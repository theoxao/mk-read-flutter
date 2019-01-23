import 'package:barcode_scan/barcode_scan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mk/helper/ensure_visiable_helper.dart';
import 'package:flutter_mk/repositories/read_repository.dart';
import 'package:flutter_umeng_analytics_fork/flutter_umeng_analytics_fork.dart';

import '../common/commons.dart';

class AddBookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddBookState();
}

class AddBookState extends State<AddBookPage> {
  String barCode = "";
  bool showBookSelect = false;
  List<FocusNode> _focusNodeList = [];
  int readStatus = 3;
  bool borrowed = false;

  @override
  void initState() {
    super.initState();
    UMengAnalytics.beginPageView("add_book");
    for (var i = 0; i < 10; i++) {
      _focusNodeList.add(FocusNode());
    }
  }

  @override
  void dispose() {
    super.dispose();
    UMengAnalytics.endPageView("add_book");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("添加书籍"),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: RaisedButton.icon(
                            color: primaryColor,
                            textColor: Colors.white,
                            onPressed: scanPressed,
                            icon: Icon(Icons.scanner),
                            label: Text("扫描ISBN码")),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: RaisedButton.icon(
                          color: primaryColor,
                          textColor: Colors.white,
                          onPressed: search,
                          icon: Flexible(
                              child: Center(child: Icon(Icons.search))),
                          label: Text("")),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Card(
                        child: CachedNetworkImage(
                          width: coverWidth,
                          height: coverHeight,
                          fit: BoxFit.fill,
                          imageUrl:
                              "http://img1.doubanio.com/vie/subject/s/pubc/s11284102.jg",
                          placeholder: Image(
                            image: AssetImage("images/ic_add_cover.png"),
                            width: coverWidth,
                            height: coverHeight,
                          ),
                        ),
                      ),
                      onTap: () {
                        print("//TODO");
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                EnsureVisibleWhenFocused(
                  focusNode: _focusNodeList[0],
                  child: Card(
                    child: TextField(
                      focusNode: _focusNodeList[0],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: "书名",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0, style: BorderStyle.none))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                EnsureVisibleWhenFocused(
                  focusNode: _focusNodeList[1],
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Card(
                          child: TextField(
                            focusNode: _focusNodeList[1],
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                labelText: "作者",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                )),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Card(
                          child: TextField(
                            focusNode: _focusNodeList[2],
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                labelText: "出版社",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                EnsureVisibleWhenFocused(
                  focusNode: _focusNodeList[3],
                  child: Card(
                    child: TextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      focusNode: _focusNodeList[3],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: "总页数",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0, style: BorderStyle.none))),
                    ),
                  ),
                ),
                EnsureVisibleWhenFocused(
                  focusNode: _focusNodeList[4],
                  child: Card(
                    child: TextFormField(
                      focusNode: _focusNodeList[4],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "选择书籍分类",
                          hintStyle: TextStyle(color: primaryColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0, style: BorderStyle.none))),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          this.setState(() {
                            this.readStatus = 3;
                          });
                        },
                        child: RadioListTile<int>(
                            title: Text("已经读完此书"),
                            value: 2,
                            groupValue: readStatus,
                            onChanged: (a) {
                              this.setState(() {
                                if (readStatus == a)
                                  this.readStatus = 3;
                                else
                                  this.readStatus = a;
                              });
                            }),
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                          title: Text("正在阅读此书"),
                          value: 1,
                          groupValue: readStatus,
                          onChanged: (a) {
                            this.setState(() {
                              if (readStatus == a)
                                this.readStatus = 3;
                              else {
                                this.readStatus = a;
                              }
                            });
                          }),
                    )
                  ],
                ),
                progressWidget,
                RadioListTile(
                  title: Text("借来的书（为您定制阅读计划）"),
                  value: true,
                  groupValue: borrowed,
                  onChanged: (a) {
                    this.setState(() {
                      this.borrowed = borrowed != a;
                    });
                  },
                ),
                borrowInfo,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void scanPressed() {
    scan();
  }

  Future scan() async {
    try {
      String barCode = await BarcodeScanner.scan();
      fetchBookByIsbn(barCode);
      setState(() {
        this.barCode = barCode;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        print("permission denied");
      } else {
        print(e.message);
      }
    }
  }

  Widget get progressWidget => Offstage(
      offstage: readStatus != 1,
      child: EnsureVisibleWhenFocused(
        focusNode: _focusNodeList[5],
        child: Card(
          child: TextField(
            keyboardType: TextInputType.numberWithOptions(),
            focusNode: _focusNodeList[5],
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: "当前页数",
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, style: BorderStyle.none))),
          ),
        ),
      ));

  Widget get borrowInfo => Offstage(
        offstage: !borrowed,
        child: Column(children: <Widget>[
          EnsureVisibleWhenFocused(
            focusNode: _focusNodeList[6],
            child: Card(
              child: TextField(
                focusNode: _focusNodeList[6],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    labelText: "归还时间",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none))),
              ),
            ),
          ),
          EnsureVisibleWhenFocused(
            focusNode: _focusNodeList[7],
            child: Card(
              child: TextField(
                focusNode: _focusNodeList[7],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    labelText: "备注",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none))),
              ),
            ),
          ),
        ]),
      );

  void search() {
    Navigator.pushNamed(context, "/search_book");
  }
}
