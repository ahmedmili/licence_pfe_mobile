import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../dimensions.dart';

class StatusWidget extends StatefulWidget {
  StatusWidget({super.key, required this.status});
  String status;

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 50,
          width: 135,
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20),
            child: Center(
              child: Text(
                widget.status,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
