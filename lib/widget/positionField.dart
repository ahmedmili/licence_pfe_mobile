import 'package:flutter/material.dart';
import 'package:saverapp/dimensions.dart';

class PositionField extends StatefulWidget {
  const PositionField({super.key});

  @override
  State<PositionField> createState() => _PositionFieldState();
}

class _PositionFieldState extends State<PositionField> {
  @override
  RangeValues _currentRangeValues = const RangeValues(0, 100);
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
                  values: _currentRangeValues,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  activeColor: Colors.green[800],
                  inactiveColor: Colors.grey,
                  labels: RangeLabels(
                    _currentRangeValues.start.toString(),
                    _currentRangeValues.end.toString(),
                  ),
                  onChangeEnd: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                  onChanged: (RangeValues values) {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
