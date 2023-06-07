import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    Key? key,
    required this.status,
    required this.isSelected,
    required this.onStatusSelected,
  }) : super(key: key);

  final String status;
  final bool isSelected;
  final Function(String) onStatusSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onStatusSelected(status);
      },
      child: Container(
        height: 50,
        width: 140,
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Material(
          elevation: isSelected ? 10.0 : 5.0,
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? Colors.green.shade800 : Colors.white,
          child: Center(
            child: Text(
              status.tr.toUpperCase(),
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
