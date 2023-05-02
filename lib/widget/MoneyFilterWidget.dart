import 'package:flutter/material.dart';

class MoneyFilter extends StatefulWidget {
  const MoneyFilter({Key? key}) : super(key: key);

  @override
  _MoneyFilterState createState() => _MoneyFilterState();
}

class _MoneyFilterState extends State<MoneyFilter> {
  RangeValues _currentRangeValues = const RangeValues(0, 1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 5000,
          divisions: 10,
          labels: RangeLabels(
            _currentRangeValues.start.toString(),
            _currentRangeValues.end.toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ),
      ),
    );
  }
}
