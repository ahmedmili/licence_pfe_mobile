import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String baseURL = "http://10.0.2.2:8000/api/";

final prefs = SharedPreferences.getInstance();
Map<String, String> headers = {
  "Content-Type": "application/json",
};

void errorSnackBar(BuildContext context, String errorMessage) {
  final snackBar = SnackBar(
    content: Text(errorMessage),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
