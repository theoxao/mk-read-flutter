import 'package:flutter/material.dart';
import 'package:flutter_mk/helper/ensure_visiable_helper.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/repositories/read_repository.dart';
import 'package:flutter_mk/views/read/book_detail_card.dart';
import 'package:flushbar/flushbar_helper.dart';

class ReadPage extends StatefulWidget {
  String logId;
  final String progress;
  final UserBook userBook;

  ReadPage(this.logId, this.progress, this.userBook, {Key key})
      : super(key: key);

  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  var pageController = TextEditingController();
  var inputDialog = PageInputDialog();
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userBook.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            BookDetailCard(widget.userBook),
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {},
                  child: Text("阅读摘录"),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text("倒计时阅读"),
                ),
              ],
            ),
            Card(
              shape: Border(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[Icon(Icons.queue_music), Text("环境音")],
                    ),
                    //TODO music list
                  ],
                ),
              ),
            ),
            EnsureVisibleWhenFocused(
              child: TextField(
                controller: pageController,
                focusNode: focusNode,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    labelText: "书名",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none))),
              ),
              focusNode: focusNode,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {},
                  child: Text("暂停"),
                ),
                RaisedButton(
                  onPressed: () {
                    String page = pageController.text;
                    if (page != null && page.length > 0)
                      ReadRepository(context).readOperation(widget.logId, widget.userBook.id, 0, page);
                    else
                      FlushbarHelper.createError(message: "page is incorrect!");
                  },
                  child: Text("结束阅读"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PageInputDialog extends Dialog {
  PageInputDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: 300,
          height: 160,
        ),
      ),
    );
  }
}
