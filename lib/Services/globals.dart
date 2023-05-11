import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/partner.dart';

// const String baseURL = "http://10.0.2.2:8000/api/";
const String baseURL = "http://192.168.100.34:8000/api/";

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
  // variables declaration

  final _email = ''.obs;
  final _token = ''.obs;
  final _role = ''.obs;
  final _firstLogin = true.obs;

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

  var partner = Partner(
    name: "",
    image: "",
    category: "",
    id: 0,
    description: "",
    email: "",
    phone: 0,
    closingtime: "",
    openingtime: "",
    likes: false,
  );

  late List<Box> _boxsList = [];
// getters
  String get email => _email.value;
  String get token => _token.value;
  String get role => _role.value;
  bool get firstLogin => _firstLogin.value;

  List<Box> get boxsList => _boxsList;

// setters
  void setEmail(String email) {
    _email.value = email;
  }

  void setToken(String token) {
    _token.value = token;
    update();
  }

  void setRole(String role) {
    _role.value = role;
  }

  void setFirstLogin(bool firstLogin) {
    _firstLogin.value = firstLogin;
  }

  void setBoxsList(List<Box> boxsList) {
    _boxsList = boxsList;
    update();
  }

  //global methodes ..
  Future<void> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token != null) {
      setToken(token);
    } else {
      setToken("");
    }
  }

  Future<void> readRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var role = prefs.getString("role");
    if (role != null) {
      setRole(role);
    } else {
      setRole("");
    }
  }
}
