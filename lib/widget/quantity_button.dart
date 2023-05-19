import 'package:flutter/material.dart';

class QantityButton extends StatefulWidget {
  @override
  _QantityButtonState createState() => _QantityButtonState();
}

class _QantityButtonState extends State<QantityButton> {
  int value = 1;

  void increment() {
    setState(() {
      value++;
    });
  }

  void decrement() {
    if (value > 1) {
      setState(() {
        value--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Valeur actuelle'),
              content: Text(value.toString()),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      minWidth: 100,
      color: Colors.green[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, color: Colors.white),
            onPressed: decrement,
          ),
          Text(
            value.toString(), // Affiche la valeur actuelle du "0"
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: increment,
          ),
        ],
      ),
    );
  }
}
