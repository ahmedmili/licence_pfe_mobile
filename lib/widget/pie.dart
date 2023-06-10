import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Services/auth.dart';
import '../Services/globals.dart';

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}

class Pie extends StatefulWidget {
  const Pie({Key? key}) : super(key: key);

  @override
  _PieState createState() => _PieState();
}

class _PieState extends State<Pie> {
  List<ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
    fetchDataForPieChart();
  }

  Future<void> fetchDataForPieChart() async {
    try {
      final token = controller.token;
      final url = Uri.parse('${baseURL}partner/getPartnerOrderCount');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<ChartData> dataPoints = [];

        data.forEach((category, value) {
          dataPoints.add(ChartData(category, value.toDouble()));
        });

        setState(() {
          chartData = dataPoints;
        });
      } else {
        throw Exception('Failed to fetch partner order count');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfCircularChart(
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.category,
            yValueMapper: (ChartData data, _) => data.value,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
            ),
          ),
        ],
      ),
    );
  }
}
