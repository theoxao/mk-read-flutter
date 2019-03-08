import 'package:flutter/material.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/common/utils.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/repositories/read_repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookStatCard extends StatelessWidget {
  final UserBook userBook;

  BookStatCard(this.userBook);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Border(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: ReadRepository(context).fetchReadStat(userBook.id),
            builder: (context, snapshot) {
              List<Widget> widgets = [];
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data;
                print(data);
                widgets.add(Row(
                  children: <Widget>[
                    Flexible(
                      child: BookStatItem(
                          Icon(Icons.timer),
                          "阅读页数",
                          Text(
                              data != null ? data['progress'] : "0/${userBook.pageCount}",
                            style: bookNameStyle,
                          )),
                    ),
                    Flexible(
                      child: BookStatItem(
                          Icon(Icons.timer),
                          "累计阅读时间",
                          Text(
                              data != null ? timeParse(data['totalDuration']) : "暂无阅读记录",
                            overflow: TextOverflow.ellipsis,
                            style: bookNameStyle,
                          )),
                    )
                  ],
                ));
                if (data != null && data['remainDays'] != null) {
                  widgets.add(Divider());
                  widgets.add(BookStatItem(
                      Icon(Icons.book),
                      "借来的书",
                      Text(
                        data['remainDays'].toString(),
                        style: bookNameStyle,
                      )));
                }
              } else {
                widgets.add(Row(
                  children: <Widget>[
                    BookStatItem(
                        Icon(Icons.timer),
                        "阅读页数",
                        SpinKitThreeBounce(
                          color: primaryColor,
                          size: primaryTextSize,
                        )),
                    Spacer(),
                    BookStatItem(
                        Icon(Icons.timer),
                        "累计阅读时间",
                        SpinKitThreeBounce(
                          color: primaryColor,
                          size: primaryTextSize,
                        )),
                    Spacer(),
                  ],
                ));
              }
              return Column(
                children: widgets,
              );
            }),
      ),
    );
  }
}

class BookStatItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final Widget child;

  BookStatItem(this.icon, this.title, this.child);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        icon,
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title),
              child,
            ],
          ),
        )
      ],
    );
  }
}
