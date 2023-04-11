import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMiddleware extends GetMiddleware {
  final String roleType;

  AuthMiddleware(this.roleType) {
    priority = 2;
  }

  Future<String> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "0";
  }

  Future<String> readRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') ?? "0";
  }

  Future<bool> checkFirstLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('firstLogin') ?? true;
  }

  @override
  RouteSettings? redirect(String? route) {
    bool isAuthenticated = (readToken()) != "0";
    bool role = (readRole()) == roleType;
    bool firstLogin = (checkFirstLogin()) == false;
    SharedPreferences.getInstance().then((value) => {value.getString("token")});
    // print("have token ?  $isAuthenticated");
    // print("roletype == $roleType");
    // print("role == ${await readRole()}");
    // print(" first Login ?? ==  $firstLogin");

    if (!isAuthenticated) {
      print('1');
      return const RouteSettings(name: '/');
    } else if (roleType != "any") {
      print('2');
      if (!role) {
        print('no permission');
        if (roleType == "user") return const RouteSettings(name: '/home');
        if (roleType == "partner") {
          return const RouteSettings(name: '/partnerHome');
        }
      }
    } else if (!firstLogin) {
      print('3');
      if (readRole() == "user") {
        print('4');
        return const RouteSettings(name: '/home');
      }
      if (readRole() == "partner") {
        print('5');
        return const RouteSettings(name: '/partnerHome');
      }
    } else {
      print('6');
    }

    return null;
  }
}
