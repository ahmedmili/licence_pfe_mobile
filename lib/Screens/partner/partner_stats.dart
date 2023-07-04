import 'package:flutter/material.dart';
import 'package:saverapp/widget/DoughnutChart.dart';
import 'package:saverapp/widget/pie.dart';

import '../../widget/chart.dart';

class PartnerStats extends StatelessWidget {
  const PartnerStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 65),
          child: Text(
            'Statistics',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(right: 90),
              child: Text(
                "Distribution of Order Status :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB2CCFF),
                ),
              ),
            ),
            const Pie(),
            const Padding(
              padding: EdgeInsets.only(right: 90),
              child: Text(
                "Monthly Sales Trend of Boxes :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB2CCFF),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Chart(),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(right: 90),
              child: Text(
                "Distribution of Box Status :",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB2CCFF),
                ),
              ),
            ),
            const DoughnutChart(),
          ],
        ),
      ),
    );
  }
}
