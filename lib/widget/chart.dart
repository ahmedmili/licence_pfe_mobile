import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Chart({Key? key}) : super(key: key);

  @override
  ChartState createState() => ChartState();
}

class ChartState extends State<Chart> {
  List<SalesData> data = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 34),
    SalesData('Apr', 32),
    SalesData('May', 40)
    // SalesData('Category 1', 25),
    // SalesData('Category 2', 50),
    // SalesData('Category 3', 75),
    // SalesData('Category 4', 40),
    // SalesData('Category 5', 60),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SfCircularChart(
        //   series: <CircularSeries<SalesData, String>>[
        //     RadialBarSeries<SalesData, String>(
        //       dataSource: data,
        //       xValueMapper: (SalesData data, _) => data.category,
        //       yValueMapper: (SalesData data, _) => data.value,
        //     ),
        //   ],
        // ),
        //Initialize the chart widget
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Half yearly sales analysis'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                  dataSource: data,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  name: 'Sales',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ]),
        //
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     //Initialize the spark charts widget
        //     child: SfSparkLineChart.custom(
        //       //Enable the trackball
        //       trackball: const SparkChartTrackball(
        //           activationMode: SparkChartActivationMode.tap),
        //       //Enable marker
        //       marker: const SparkChartMarker(
        //           displayMode: SparkChartMarkerDisplayMode.all),
        //       //Enable data label
        //       labelDisplayMode: SparkChartLabelDisplayMode.all,
        //       xValueMapper: (int index) => data[index].year,
        //       yValueMapper: (int index) => data[index].sales,
        //       dataCount: 5,
        //     ),
        //   ),
        // )
      ],
    );
  }
}

// SalesData('Category 1', 25),
class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
// class SalesData {
//   SalesData(this.category, this.value);

//   final String category;
//   final double value;
// }
