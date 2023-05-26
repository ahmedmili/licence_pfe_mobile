import 'package:flutter/material.dart';

import '../../widget/chart.dart';

class PartnerStats extends StatelessWidget {
  const PartnerStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 350,
              width: 200,
              child: Chart(),
            ),
          ),
        ],
      ),
    );
  }
}
