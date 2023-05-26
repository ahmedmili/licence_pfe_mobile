import 'package:saverapp/Services/partners.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Chart({Key? key}) : super(key: key);

  @override
  ChartState createState() => ChartState();
}

class ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PartnersService.getPartnerBoxStats("all"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Map<String, dynamic>> data = snapshot.data!;
          final List<SalesData> salesDataList = data.map((item) {
            return SalesData(item['monthName'], item['count']);
          }).toList();
          return Column(
            children: [
              //Initialize the chart widget
              SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Box Posted'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<SalesData, String>>[
                    LineSeries<SalesData, String>(
                        dataSource: salesDataList,
                        xValueMapper: (SalesData sales, _) => sales.month,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        name: 'Boxs',
                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                  ]),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green[800]!),
              strokeWidth: 5,
            ),
          );
        }
      },
    );
  }
}

class SalesData {
  SalesData(this.month, this.sales);

  final String month;
  final double sales;
}
