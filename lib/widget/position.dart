import 'package:flutter/material.dart';

class Position extends StatefulWidget {
  const Position({super.key});

  @override
  State<Position> createState() => _PositionState();
}

class _PositionState extends State<Position> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        top: 630,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Colors.white),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "select distance",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              SizedBox(
                width: 200,
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.green[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "APPLY",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
