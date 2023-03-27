import 'package:flutter/material.dart';

const String baseURL = "http://10.0.2.2:8000/api/";
const Map<String, String> headers = {"Content-Type": "application/json"};

void errorSnackBar(BuildContext context, String errorMessage) {
  final snackBar = SnackBar(
    content: Text(errorMessage),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
