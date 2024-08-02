// ignore_for_file: file_names

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tempsensorapp/api.dart';

class SyncFusionPlotter extends StatelessWidget {
  final double circleRadius;

  SyncFusionPlotter(this.circleRadius, {super.key});
  String titleText = "";
  final String periodText = "daily";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sensor>>(
      future: getsensorsList(periodText),
      builder: (BuildContext context, AsyncSnapshot<List<Sensor>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          if (periodText == "monthly" || periodText == "weekly") {
            titleText =
                "Temperature  ${snapshot.data!.first.date.day}/${snapshot.data!.first.date.month} - ${snapshot.data!.last.date.day}/${snapshot.data!.last.date.month} ";
          } else if (titleText == "daily") {
            titleText =
                "Temperature  ${snapshot.data!.first.date.hour}:${snapshot.data!.first.date.minute} - ${snapshot.data!.last.date.hour}:${snapshot.data!.last.date.minute}";
          }
          return Flexible(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.only(bottom: 20, right: 20),
                  color: Colors.white,
                  child: SfCartesianChart(
                    title: ChartTitle(
                        text: titleText, textStyle: TextStyle(fontSize: 10)),
                    primaryXAxis: DateTimeAxis(),
                    primaryYAxis: NumericAxis(),
                    series: [
                      AreaSeries<Sensor, DateTime>(
                          name: "S1",
                          opacity: 0.5,
                          borderColor: Colors.black,
                          trendlines: [],
                          color: Colors.blue,
                          dataSource: snapshot.data,
                          xValueMapper: (Sensor d, _) => d.date,
                          yValueMapper: (Sensor d, _) => d.temperatorValue),
                    ],
                  )));
        }
      },
    );
  }
}
