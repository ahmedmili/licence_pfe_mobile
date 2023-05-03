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
          Container(
            width: 340,
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
          Expanded(
            child: FutureBuilder(
              future: UserService.filterPrice(5.00, 20.00),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data![1].id);
                  controller.setBoxsList(snapshot.data!);
                  return Text("data");
                } else {
                  return Text("no data");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
