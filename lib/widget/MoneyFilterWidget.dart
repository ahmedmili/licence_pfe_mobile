import 'package:flutter/material.dart';

class MoneyFilter extends StatefulWidget {
  const MoneyFilter({Key? key}) : super(key: key);

  @override
  _MoneyFilterState createState() => _MoneyFilterState();
}

class _MoneyFilterState extends State<MoneyFilter> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 100,
          divisions: 10,
          activeColor: Colors.green[800],
          inactiveColor: Colors.grey,
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
