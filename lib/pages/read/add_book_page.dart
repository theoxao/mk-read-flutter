import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mk/blocs/read/book_bloc.dart';
import 'package:flutter_mk/blocs/read/shlef_bloc.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/helper/ensure_visiable_helper.dart';
import 'package:flutter_mk/models/book.dart';
import 'package:flutter_mk/models/shelf_models.dart';
import 'package:flutter_mk/pages/read/select_book_page.dart';
import 'package:flutter_mk/repositories/read_repository.dart';

class AddBookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddBookState();
}

class FinalBody {
  var isbn;
  var cover;
  var name;
  var author;
  var publisher;
  var pageCount;
  var tag;
  var currentPage;
  var state;
  var refBookId;
  var returnDate;
  var remark;
}

class RequestBody {
  List<String> fieldList = [
    "isbn",
    "cover",
    "name",
    "author",
    "publisher",
    "pageCount",
    "tag",
    "currentPage",
    "state",
    "refBookId",
    "returnDate",
    "remark"
  ];
  Map<String, TextEditingController> controllerMap = Map();

  RequestBody() {
    fieldList.forEach((key) {
      controllerMap[key] = TextEditingController();
    });
  }
}

class AddBookState extends State<AddBookPage> {
  String barCode = "";
  bool showBookSelect = false;
  List<FocusNode> _focusNodeList = [];
  int readStatus = 3;
  bool borrowed = false;
  String returnDate = "";
  String refBookId;
  String cover;
  File _image;

  SelectedBookBLoc selectedBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  RequestBody _requestBody = RequestBody();

  coverImage(String cover) {
    if (ObjectUtil.isNotEmpty(cover)) {
      return Image.network(
        cover,
        width: coverWidth,
        height: coverHeight,
        fit: BoxFit.cover,
      );
    } else if (_image != null) {
      return Image.file(
        _image,
        width: coverWidth,
        height: coverHeight,
      );
    } else {
      return Image.asset(
        "image/ic_add_cover.png",
        width: coverWidth,
        height: coverHeight,
      );
    }
  }

  @override
  void initState() {
    selectedBloc = SelectedBookBLoc();
    super.initState();
    for (var i = 0; i < 10; i++) {
      _focusNodeList.add(FocusNode());
    }
  }

  @override
  void dispose() {
    selectedBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("添加书籍"),
      ),
      body: SafeArea(
          top: false,
          bottom: false,
          child: StreamBuilder<Book>(
            stream: selectedBloc.stream,
            builder: (streamContext, AsyncSnapshot<Book> snapshot) {
              Book book = Book();
              if (snapshot.hasData) book = snapshot.data;
              refBookId = book.id;
              cover = book.cover;
              _requestBody.controllerMap["name"].text = book.name;
              _requestBody.controllerMap["author"].text = book.author;
              _requestBody.controllerMap["publisher"].text = book.publisher;
              _requestBody.controllerMap["pageCount"].text = book.pageCount;
              return SingleChildScrollView(
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
                                label: Text(barCode)),
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
                            child: coverImage(book.cover),
                          ),
                          onTap: () {
                            showDialog(
                              context: streamContext,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(64.0),
                                  child: Center(
                                    child: Container(
                                      height: 100,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
//                                              getImage(ImageSource.camera);
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
//                                              getImage(ImageSource.gallery);
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
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    EnsureVisibleWhenFocused(
                      focusNode: _focusNodeList[0],
                      child: Card(
                        child: TextField(
                          controller: _requestBody.controllerMap["name"],
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
                                controller:
                                    _requestBody.controllerMap["author"],
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
                                controller:
                                    _requestBody.controllerMap["publisher"],
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
                          controller: _requestBody.controllerMap["pageCount"],
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
                        child: TextField(
                          onTap: _selectTag,
                          controller: _requestBody.controllerMap["tag"],
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
                    RaisedButton(
                      onPressed: addBook,
                      child: Text("添加"),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }

//  Future getImage(ImageSource source) async {
//    var image = await ImagePicker.pickImage(source: source);
//
//    setState(() {
//      _image = image;
//    });
//  }

  void addBook() {
    var controlMap = _requestBody.controllerMap;
    var body = Map<String, String>();
    body["isbn"] = barCode;
    body["name"] = controlMap["name"].text;
    body["author"] = controlMap["author"].text;
    body["publisher"] = controlMap["publisher"].text;
    body["pageCount"] = controlMap["pageCount"].text;
    body["remark"] = controlMap["remark"].text;
    body["returnDate"] = controlMap["returnDate"].text;
    body["currentPage"] = controlMap["currentPage"].text;
    body["tag"] = controlMap["tag"].text;
    body["refBookId"] = refBookId;
    body["state"] = readStatus.toString();
    body["cover"] = cover;
    ReadRepository(context).addBook(body);
  }

  void scanPressed() {
    scan();
  }

  Future scan() async {
    try {
      String barCode = await BarcodeScanner.scan();
      this.barCode = barCode;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return SelectBookPage(isbn: barCode, bloc: selectedBloc);
      }));
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
            controller: _requestBody.controllerMap["currentPage"],
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

  Widget get borrowInfo {
    return Offstage(
      offstage: !borrowed,
      child: Column(children: <Widget>[
        EnsureVisibleWhenFocused(
          focusNode: _focusNodeList[6],
          child: Card(
            child: TextField(
              controller: _requestBody.controllerMap["returnDate"],
              focusNode: _focusNodeList[6],
              onTap: _showDatePicker,
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
              controller: _requestBody.controllerMap["remark"],
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
  }

  void _selectTag() async {
    TagListBloc bloc = TagListBloc();
    _focusNodeList[4].unfocus();
    await showDialog(
        context: context,
        builder: (context) {
          return StreamBuilder(
            stream: bloc.stream,
            builder: (context, AsyncSnapshot<List<Tag>> snapshot) {
              if (snapshot.hasData && snapshot.data.length > 0) {
                var list = snapshot.data;
                return Column(
                  children: list.map((tag) {
                    return Text(tag.tag);
                  }).toList(),
                );
              } else
                return Container();
            },
          );
        });
  }

  void _showDatePicker() async {
    var now = DateTime.now();
    var lastDate = DateTime(now.year + 1, now.month, now.day);
    DateTime initDate;
    var preSelected = _requestBody.controllerMap["returnDate"].text;
    if (ObjectUtil.isNotEmpty(preSelected)) {
      initDate = DateUtil.getDateTime(preSelected);
    } else {
      initDate = DateTime.fromMillisecondsSinceEpoch(
          now.millisecondsSinceEpoch + 25 * 3600 * 1000);
    }

    var date = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime.now(),
      lastDate: lastDate,
    );
    _focusNodeList[6].unfocus();
    _requestBody.controllerMap["returnDate"].text =
        DateUtil.getDateStrByDateTime(date, format: DateFormat.YEAR_MONTH_DAY);
  }

  void search() {
    Navigator.pushNamed(context, "/search_book");
  }
}
