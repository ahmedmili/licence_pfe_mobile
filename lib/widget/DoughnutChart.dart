// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Services/auth.dart';
import '../Services/globals.dart';

class ChartData {
  final String category;
  final double value;
  final Color color;

  ChartData(this.category, this.value, this.color);
}

class DoughnutChart extends StatefulWidget {
  const DoughnutChart({Key? key}) : super(key: key);

  @override
  _DoughnutChartState createState() => _DoughnutChartState();
}

class _DoughnutChartState extends State<DoughnutChart> {
  List<ChartData> chartData = [];
  List<Color> categoryColors = const [
    Color.fromRGBO(255, 217, 184, 1.0),
    Color.fromARGB(255, 31, 67, 137),
    Color.fromARGB(255, 73, 7, 40),
    Color(0xFFFFB2D9),
    Color(0xFFB2CCFF),
  ];

  @override
  void initState() {
    super.initState();
    fetchDataForDoughnutChart();
  }

  Future<void> fetchDataForDoughnutChart() async {
    try {
      final token = controller.token;
      final url = Uri.parse(
          '${baseURL}partner/getTotalBoxCountsstat'); // Mettez à jour l'URL de l'API
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<ChartData> dataPoints = [];

        data.forEach((category, value) {
          int index = dataPoints.length % categoryColors.length;
          Color color = categoryColors[index];
          dataPoints.add(ChartData(category, value.toDouble(), color));
        });

        setState(() {
          chartData = dataPoints;
        });
      } else {
        throw Exception('Failed to fetch box counts');
      }
    } catch (error) {
      // print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (chartData.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB2CCFF)),
          strokeWidth: 5,
        ),
      );
    } else {
      return Center(
        child: Row(
          children: [
            Expanded(
              child: SfCircularChart(
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.category,
                    yValueMapper: (ChartData data, _) => data.value,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                    ),
                    pointColorMapper: (ChartData data, _) {
                      int index =
                          chartData.indexOf(data) % categoryColors.length;
                      return categoryColors[index];
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: chartData.map((data) {
                  int index = chartData.indexOf(data) % categoryColors.length;
                  return Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.only(right: 5),
                        color: categoryColors[index],
                      ),
                      Text(data.category),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }
  }
}
