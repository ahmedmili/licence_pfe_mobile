import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/partner.dart';

// const String localhost = "192.168.137.224";
const String localhost = "172.20.10.2";

// const String localhost = "10.0.2.2";

const String baseURL = "http://$localhost:8000/api/";

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
    lat: 0,
    long: 0,
    adress: "",
    likes: false,
  );
  var _box = Box(
    newprice: "",
    startdate: "",
    enddate: "",
    quantity: 0,
    remainingQuantity: 0,
    image: "",
    category: "",
    partnerId: 0,
    id: 0,
    title: "",
    description: "",
    oldprice: "",
  );

  late List<Box> _boxsList = [];
// getters
  String get email => _email.value;
  String get token => _token.value;
  String get role => _role.value;
  bool get firstLogin => _firstLogin.value;
  Box get box => _box;

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

  void setBox(Box box) {
    _box = box;
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

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token")!.isNotEmpty) {
      prefs.setString("token", "");
      prefs.setString("role", "");
      setToken("");
      setRole("");
    }
    Get.offAllNamed("/");
  }

  var value = 1.obs; // Define an observable variable
}
