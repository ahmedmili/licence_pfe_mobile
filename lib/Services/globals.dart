import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class GlobalController extends GetxController {
  var _email = ''.obs;
  var _token = ''.obs;
  var _role = ''.obs;

  String get email => _email.value;
  String get token => _token.value;
  String get role => _role.value;

  void setEmail(String email) {
    _email.value = email;
  }

  void setToken(String token) {
    _token.value = token;
  }

  void setRole(String role) {
    _role.value = role;
  }
}
