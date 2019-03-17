import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/read/read_bloc.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/common/utils.dart';
import 'package:flutter_mk/models/read_detail_models.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/pages/read/progress_detail_page.dart';
import 'package:flutter_mk/repositories/read_repository.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ReadProgressCard extends StatelessWidget {
  final UserBook userBook;
  final ReadProgressBloc bloc;

  ReadProgressCard(this.userBook) : bloc = ReadProgressBloc(userBook.id);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Border(),
      child: StreamBuilder(
        stream: bloc.stream,
        builder: (context, AsyncSnapshot<List<ReadProgress>> snapshot) {
          List<Widget> columns = [
            Row(
              children: <Widget>[
                Icon(Icons.assessment),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("阅读进度"),
                ),
                Expanded(
                  child: Container(),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProgressDetailPage(userBook: userBook);
                    }));
                  },
                  child: Icon(Icons.chevron_right),
                )
              ],
            ),
          ];
          if (snapshot.hasData) {
            var progresses = snapshot.data;
            if (progresses != null && progresses.isNotEmpty) {
              for (var progress in progresses) {
                if (progress != null) {
                  columns.add(Divider());
                  columns.add(Row(
                    children: <Widget>[
                      Text(
                        progress.currentPage.toString() + "页",
                        style: bookNameStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(DateUtil.getDateStrByMs(progress.startAt,
                            format: DateFormat.ZH_YEAR_MONTH_DAY)),
                      ),
                      Spacer(),
                      Text(timeParse(progress.duration))
                    ],
                  ));
                }
              }
            }
          } else {
            columns.add(SpinKitThreeBounce(
              color: primaryColor,
              size: primaryTextSize,
            ));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: columns,
            ),
          );
        },
      ),
    );
  }
}
