import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Models/boxs.dart';
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
  final _email = ''.obs;
  final _token = ''.obs;
  final _role = ''.obs;
  final box = Box(
    newprice: "",
    startdate: "",
    enddate: "",
    quantity: 0,
    remaining_quantity: 0,
    image: "",
    category: "",
    partnerId: 0,
    id: 0,
    title: "",
    description: "",
    oldprice: "",
  );
  late List<Box> _boxsList;

  String get email => _email.value;
  String get token => _token.value;
  String get role => _role.value;

  List<Box> get boxsList => _boxsList;

  void setEmail(String email) {
    _email.value = email;
  }

  void setToken(String token) {
    _token.value = token;
  }

  void setRole(String role) {
    _role.value = role;
  }

  void setBoxsList(List<Box> boxsList) {
    _boxsList = boxsList;
  }
}
