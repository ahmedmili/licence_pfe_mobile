import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}

class Pie extends StatefulWidget {
  const Pie({super.key});

  @override
  _PieState createState() => _PieState();
}

class _PieState extends State<Pie> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfCircularChart(
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
            dataSource: <ChartData>[
              ChartData('Catégorie 1', 25),
              ChartData('Catégorie 2', 35),
              ChartData('Catégorie 3', 40),
            ],
            xValueMapper: (ChartData data, _) => data.category,
            yValueMapper: (ChartData data, _) => data.value,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
            ),
          )
        ],
      ),
    );
  }
}
