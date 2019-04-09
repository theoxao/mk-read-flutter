import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/read/music_bloc.dart';
import 'package:flutter_mk/blocs/timer_bloc.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/helper/ensure_visiable_helper.dart';
import 'package:flutter_mk/helper/timer_page.dart';
import 'package:flutter_mk/models/music.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/pages/read/add_excerpt_page.dart';
import 'package:flutter_mk/repositories/read_repository.dart';
import 'package:flutter_mk/views/read/book_detail_card.dart';
import 'package:audioplayer/audioplayer.dart';

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
  MusicBloc musicBloc;
  AudioPlayer audioPlayer = AudioPlayer();
  int playingId = 0;
  var focusNode = FocusNode();
  TimerBloc timerbloc;
  int startAt = 0;

  @override
  void initState() {
    musicBloc = MusicBloc();
    if (widget.userBook.recentRecord?.status == 1) {
      startAt = widget.userBook.recentRecord?.startAt;
    }
    timerbloc = TimerBloc(startAt, widget.userBook.recentRecord?.duration);
    super.initState();
  }

  @override
  void dispose() {
    timerbloc.close();
    musicBloc.close();
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
                  bloc: timerbloc,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () async {
                      await showAddExcerptSheet();
                    },
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
                      musicList
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
        builder: (context) {
          return _SystemPadding(
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
                      decoration:
                          InputDecoration(labelText: '请输入页数', hintText: '0'),
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
                        this.setState(() {
                          startAt = 0;
                        });
                        Navigator.pop(context);
                      });
                    })
              ],
            ),
          );
        });
  }

  Widget get musicList => StreamBuilder(
        stream: musicBloc.stream,
        builder: (context, AsyncSnapshot<List<Music>> snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            var list = snapshot.data;
            return Column(
              children: list.map((music) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(music.name),
                          Expanded(
                            child: Container(),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await audioPlayer.stop();
                              if (playingId == music.id) {
                                this.setState(() {
                                  playingId = 0;
                                });
                              } else {
                                await audioPlayer.play(music.path);
                                this.setState(() {
                                  playingId = music.id;
                                });
                              }
                            },
                            child: Icon(playingId == music.id
                                ? Icons.pause
                                : Icons.play_arrow),
                          )
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                );
              }).toList(),
            );
          }
          return Container();
        },
      );

  Future showAddExcerptSheet() async {
    var _controller = TextEditingController();
    var _focusNode = FocusNode();

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "添加摘录",
                    style: bookNameStyle,
                  ),
                  EnsureVisibleWhenFocused(
                    child: Card(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.numberWithOptions(),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            labelText: "当前页数",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                            )),
                      ),
                    ),
                    focusNode: _focusNode,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  RaisedButton(
                    child: Text("click me "),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          );
        });
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
