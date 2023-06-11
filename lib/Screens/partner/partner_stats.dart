import 'package:flutter/material.dart';
import 'package:saverapp/widget/DoughnutChart.dart';
import 'package:saverapp/widget/pie.dart';

import '../../dimensions.dart';
import '../../widget/chart.dart';

class PartnerStats extends StatelessWidget {
  const PartnerStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
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
            Pie(),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 200),
              child: SizedBox(
                height: 400,
                width: 400,
                child: Chart(),
              ),
            ),
            DoughnutChart(),
          ],
        ),
      ),
    );
  }
}
