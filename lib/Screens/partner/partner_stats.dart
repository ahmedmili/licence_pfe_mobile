import 'package:flutter/material.dart';

import '../../dimensions.dart';
import '../../widget/chart.dart';

class PartnerStats extends StatelessWidget {
  const PartnerStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: Dimensions.width20),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 180),
            child: SizedBox(
              height: 400,
              width: 400,
              child: Chart(),
            ),
          ),
        ],
      ),
    );
  }
}
