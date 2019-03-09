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
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userBook.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                      _showPageInput();
//                    String page = pageController.text;
//                      ReadRepository(context).readOperation(widget.logId, widget.userBook.id, 0, page);
                    },
                    child: Text("结束阅读"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _showPageInput() async {

    String pageCount ="";
    await showDialog<String>(
      context: context,
      child:  _SystemPadding(child:  AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content:  Row(
          children: <Widget>[
             Expanded(
              child:  TextField(
                keyboardType: TextInputType.number  ,
                onChanged: (value){pageCount=value;},
                autofocus: true,
                decoration:  InputDecoration(
                    labelText: 'Full Name', hintText: 'eg. John Smith'),
              ),
            )
          ],
        ),
        actions: <Widget>[
           RaisedButton(
              child: const Text('OPEN'),
              onPressed: () {
                ReadRepository(context).readOperation(widget.logId, widget.userBook.id, 0, pageCount);
                Navigator.pop(context);
              })
        ],
      ),),
    );
  }


}

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: EdgeInsets.only(bottom: 0),
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
