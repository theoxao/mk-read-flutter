import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/read/read_bloc.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/common/utils.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:super_tooltip/super_tooltip.dart';

class BookStatCard extends StatelessWidget {
  final UserBook userBook;
  final ReadStatBloc bloc;

  BookStatCard(this.userBook) :bloc= ReadStatBloc(userBook.id);




  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Border(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream:bloc.stream,
            builder: (context, snapshot) {
              List<Widget> widgets = [];
              if (snapshot.hasData) {
                var data = snapshot.data;
                print(data);
                widgets.add(Row(
                  children: <Widget>[
                    Flexible(
                      child: BookStatItem(
                          Icon(Icons.timer),
                          "阅读页数",
                          Text(
                            data != null
                                ? data['progress']
                                : "0/${userBook.pageCount}",
                            style: bookNameStyle,
                          )),
                    ),
                    Flexible(
                      child: BookStatItem(
                          Icon(Icons.timer),
                          "累计阅读时间",
                          Text(
                            data != null
                                ? timeParse(data['totalDuration'])
                                : "暂无阅读记录",
                            overflow: TextOverflow.ellipsis,
                            style: bookNameStyle,
                          )),
                    )
                  ],
                ));
                if (data != null && data['remainDays'] != null) {
                  widgets.add(Divider());
                  widgets.add(Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      BookStatItem(
                          Icon(Icons.book),
                          "借来的书",
                          Text(
                            data['remainDays'].toString(),
                            style: bookNameStyle,
                          )
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      FutureBuilder(
                        future: Future.value(userBook.remark),
                        builder: (context , snapshot){
                          if(snapshot.hasData && ObjectUtil.isNotEmpty
                            (snapshot.data)){
                            var toolTip = SuperTooltip(
                              arrowLength: 10,
                              hasShadow: false,
                              borderWidth: 0,
                              popupDirection: TooltipDirection.left,
                              content: Text(snapshot.data,style:bookNameStyle),
                            );

                            return GestureDetector(
                              onTap: (){toolTip.show(context);},
                              child: Row(
                                children: <Widget>[
                                  Text("归还信息"),
                                  Icon(Icons.info)
                                ],
                              ),
                            );
                          }
                          else{
                            return Container();
                          }
                        },
                      )
                    ],
                  ));
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
