import 'package:flutter/material.dart';
import 'package:flutter_mk/blocs/stat/stat_bloc.dart';
import 'package:flutter_mk/models/stat_models.dart';
import 'package:common_utils/common_utils.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatChartView extends StatefulWidget {
  final String refBook;

  const StatChartView({Key key, this.refBook}) : super(key: key);

  @override
  _StatChartViewState createState() => _StatChartViewState();
}

class _StatChartViewState extends State<StatChartView> {
  List<ChartTab> tabs = [
    ChartTab(icon: Icons.event_available, text: "阅读页数", value: "0"),
    ChartTab(icon: Icons.rss_feed, text: "阅读时长(分钟)", value: "1")
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: tabs,
        ),
        ChartView(
          refBook: widget.refBook,
        )
      ],
    );
  }
}

class ChartView extends StatefulWidget {
  final String refBook;

  final StatBloc bloc;

  ChartView({this.refBook}) : bloc = StatBloc(refBook: refBook);

  @override
  _ChartViewState createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: StreamBuilder(
        stream: widget.bloc.stream,
        builder: (context, AsyncSnapshot<List<Coordinate>> snapshot) {
          if (snapshot.hasData && snapshot.data.length>0) {
            var list = snapshot.data.map((c) {
              return TimeLine.fromCoordinate(c);
            }).toList();
            return charts.TimeSeriesChart(
              buildData(list),
              behaviors: [
                new charts.SlidingViewport(),
                new charts.PanAndZoomBehavior(),
//              new charts.PanBehavior(),
              ],
              defaultRenderer: new charts.BarRendererConfig<DateTime>(),
              primaryMeasureAxis: new charts.NumericAxisSpec(
                  tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                      desiredTickCount: 5, dataIsInWholeNumbers: false),
                  renderSpec: charts.GridlineRendererSpec(
                      lineStyle: charts.LineStyleSpec(
                    dashPattern: [4, 4],
                  ))),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  List<charts.Series<TimeLine, DateTime>> buildData(List<TimeLine> list) => [
        charts.Series<TimeLine, DateTime>(
          domainFn: (TimeLine data, int index) => data.x,
          measureFn: (TimeLine data, int index) => data.y / 1000 / 60,
          data: list,
          id: "stat",
        )
      ];
//
//  List<charts.Series<Coordinate, String>> buildData(List<Coordinate> list) => [
//        charts.Series<Coordinate, String>(
//          domainFn: (Coordinate data, int index) => data.x,
//          measureFn: (Coordinate data, int index) => data.y,
//          data: list,
//          id: "stat",
//        )
//      ];
}

class TimeLine {
  DateTime x;
  int y;

  TimeLine.fromCoordinate(Coordinate co) {
    x = DateUtil.getDateTime(co.x);
    y = co.y;
  }
}

class ChartTab extends StatelessWidget {
  final IconData icon;
  final String text;
  final String value;

  const ChartTab({Key key, this.icon, this.text, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        Text(text),
      ],
    );
  }
}
