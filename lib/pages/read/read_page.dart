import 'package:flutter/material.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/repositories/read_repository.dart';
import 'package:flutter_mk/views/read/book_detail_card.dart';

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
                    readOperation(widget.logId, widget.userBook.id, 0, 10);
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



class PageInputDialog extends Dialog{

  PageInputDialog({Key key}):super(key:key) ;

  @override
  Widget build(BuildContext context) {

  }
}