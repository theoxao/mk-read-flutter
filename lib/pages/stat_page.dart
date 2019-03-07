import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_mk/blocs/stat_bloc.dart';
import 'package:flutter_mk/models/stat_models.dart';

class StatChart extends StatelessWidget {
  List<charts.Series> seriesList;
  final bool animate;
  var statBloc = StatBloc();

  StatChart(this.seriesList, {this.animate});

  factory StatChart.withSampleData() {
    return StatChart(
      [],
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder(
          stream: statBloc.stream,
          builder: (context, AsyncSnapshot<List<Coordinate>> snapshot) {
            if (snapshot.hasData) {
              var list = snapshot.data;
              var globalSalesData = list.map((data) {
                return OrdinalSales(data.x, data.y);
              });

              seriesList = [
                charts.Series<OrdinalSales, String>(
                  id: 'Global Revenue',
                  domainFn: (OrdinalSales sales, _) => sales.year,
                  measureFn: (OrdinalSales sales, _) => sales.sales,
                  data: globalSalesData,
                )
              ];
              return charts.BarChart(
                seriesList,
                animate: animate,
                layoutConfig: charts.LayoutConfig(
                  leftMarginSpec: charts.MarginSpec.fixedPixel(40),
                  bottomMarginSpec: charts.MarginSpec.fixedPixel(600),
                  rightMarginSpec: charts.MarginSpec.fixedPixel(40),
                  topMarginSpec: charts.MarginSpec.fixedPixel(40),
                ),
              );
            }
          }),
    );
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
