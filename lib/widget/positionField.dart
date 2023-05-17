import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/dimensions.dart';

import '../Services/geoLocator.dart';

class PositionField extends StatefulWidget {
  const PositionField({super.key});

  @override
  State<PositionField> createState() => _PositionFieldState();
}

class _PositionFieldState extends State<PositionField> {
  GeoLocatorController geoController = Get.find<GeoLocatorController>();

  @override
  RangeValues _currentRangeValues = const RangeValues(1, 100);
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 80,
          width: 400,
          padding: EdgeInsets.only(
              left: Dimensions.width10, right: Dimensions.width10),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            color: Colors.white.withOpacity(0.5),
            child: Column(
              children: [
                const SizedBox(height: 5),
                const Center(
                  child: Text(
                    "select distance",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RangeSlider(
                  values: RangeValues(1.0, _currentRangeValues.end),
                  min: 1.0,
                  max: 100,
                  divisions: 100,
                  activeColor: Colors.green[800],
                  inactiveColor: Colors.grey,
                  labels: RangeLabels(
                    "1.0",
                    _currentRangeValues.end.toString(),
                  ),
                  onChangeEnd: (RangeValues values) {
                    setState(() {});
                    print(values.end);
                    geoController.distance.value = values.end.toInt();
                  },
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
