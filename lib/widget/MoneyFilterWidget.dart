import 'package:flutter/material.dart';
import 'package:saverapp/Services/users.dart';

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
      body: Column(
        children: [
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

              UserService.filterPrice(values.start, values.end).then((data) {
                // print(data.length);
                controller.setBoxsList(data);
              });
            },
            onChanged: (RangeValues values) {
              // print("loadeing");
            },
          ),
          const Expanded(
            child: Center(
              child: Text("Loading..."),
            ),
          ),
        ],
      ),
    );
  }
}
