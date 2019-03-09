import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/read/read_bloc.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/models/recent_record.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/pages/read/read_page.dart';
import 'package:flutter_mk/repositories/read_repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookDetailCard extends StatefulWidget {
  final String id;

  BookDetailCard(this.id);

  @override
  State<StatefulWidget> createState() {
    return BookDetailCardState(id);
  }
}

class BookDetailCardState extends State<BookDetailCard> {
  final String id;

  BookDetailCardState(this.id);

  @override
  Widget build(BuildContext context) {
    UserBookDetailBloc bloc = UserBookDetailBloc(id);
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, AsyncSnapshot<UserBook> snapshot) {
        if (snapshot.hasData) {
          var userBook = snapshot.data;
          var recentRecord = userBook.recentRecord;
          return Card(
            shape: Border(),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 1,
                    shape: Border(),
                    child: Image.network(
                      userBook.cover,
                      fit: BoxFit.cover,
                      width: coverWidth,
                      height: coverHeight,
                      scale: 80.0 / 110.0,
//            fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      userBook.name,
                      style: bookNameStyle,
                    ),
                    Text(
                      userBook.author,
                      style: bookAuthorStyle,
                    ),
                    Text(
                      userBook.createAt.toString(),
                      style: TextStyle(fontSize: thirdTextSize),
                    ),
                    Row(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            if (recentRecord.status == 0 ||
                                id == recentRecord.refBook)

                            ReadRepository(context)
                                .readOperation("", userBook.id, 1, "0")
                                .then((logId) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ReadPage(logId, "", userBook);
                              }));
                            });
                          },
                          child: Text(handleRecentBook(id, recentRecord)),
                        ),
                        RaisedButton(
                          onPressed: addRecord,
                          child: Icon(Icons.add),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        }
        else {
          return Card(
              child: SpinKitThreeBounce(
                color: primaryColor,
                size: primaryTextSize,
              )
          );
        }
      },
    );
  }

  String handleRecentBook(String id, RecentRecord recentRecord) {
    if (recentRecord.status == 0) return "开始阅读";
    if (recentRecord.refBook == id)
      return "阅读中...";
    else
      return "正在阅读其他书籍";
  }

  void addRecord() {}
}
