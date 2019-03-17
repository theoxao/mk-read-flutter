import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/read/read_bloc.dart';
import 'package:flutter_mk/common/commons.dart';
import 'package:flutter_mk/common/utils.dart';
import 'package:flutter_mk/models/read_detail_models.dart';
import 'package:flutter_mk/models/user_book.dart';
import 'package:flutter_mk/views/stat/common_stat_view.dart';

class ProgressDetailPage extends StatelessWidget {
  final UserBook userBook;
  final ReadProgressBloc bloc;

  ProgressDetailPage({Key key, this.userBook})
      : bloc = ReadProgressBloc(userBook.id, size: 20),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(userBook.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                chartCard,
                progressCard,
              ],
            ),
          ),
        ));
  }


  Widget get chartCard =>
      Card(
        child: StatChartView(refBook: userBook.id,),
//        child: StatChartView(),
      );

  Widget get progressCard =>
      Card(
        child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, AsyncSnapshot<List<ReadProgress>> snapshot) {
            if (snapshot.hasData) {
              var list = snapshot.data;
              return Column(
                children: list.map((progress) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                progress.currentPage.toString() + "页",
                                style: bookNameStyle,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(DateUtil.getDateStrByMs(
                                    progress.startAt,
                                    format: DateFormat.ZH_YEAR_MONTH_DAY)),
                              ),
                              Spacer(),
                              Text(timeParse(progress.duration))
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  );
                }).toList(),
              );
            } else {
              return Container(
                color: Colors.white,
              );
            }
          },
        ),
      );
}
