import 'package:flutter/material.dart';
import 'package:flutter_mk/helper/timer_page.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/repositories/read_repository.dart';
import 'package:flutter_mk/views/read/book_detail_card.dart';

class ReadPage extends StatefulWidget {
  final String logId;
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
  Dependencies dependencies;

  @override
  void initState() {
    int startAt = 0;
    if (widget.userBook.recentRecord?.status == 1){
      startAt=widget.userBook.recentRecord?.startAt;
    }
    dependencies = Dependencies(startAt: startAt ,duration:widget.userBook.recentRecord?.duration);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
              BookDetailCard(widget.userBook.id),
              SizedBox(
                height: 200,
                child: TimerPage(
                  dependencies: dependencies,
                ),
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
                        children: <Widget>[
                          Icon(Icons.queue_music),
                          Text("环境音")
                        ],
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
    String pageCount = "";
    await showDialog<String>(
      context: context,
      child: _SystemPadding(
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    pageCount = value;
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Full Name', hintText: 'eg. John Smith'),
                ),
              )
            ],
          ),
          actions: <Widget>[
            RaisedButton(
                child: const Text('OPEN'),
                onPressed: () {
                  ReadRepository(context)
                      .readOperation(
                          widget.logId, widget.userBook.id, 0, pageCount)
                      .then((value) {
                    Navigator.pop(context);
                  });
                })
          ],
        ),
      ),
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
