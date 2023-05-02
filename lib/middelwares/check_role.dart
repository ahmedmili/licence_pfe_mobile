// // ignore_for_file: file_names

// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RoleMiddleware extends GetMiddleware {
//   final String roleType;

//   RoleMiddleware(this.roleType) {
//     priority = 1;
//   }

//   Future<String> readRole() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('role') ?? "0";
//   }

//   @override
//   RouteSettings? redirect(String? route) {
//     bool role = (readRole() == roleType);
//     // If the user is didn't have the same acess role, continue to the requested route
//     if (!role) {
//       print('no permission');
//       if (roleType == "user") return const RouteSettings(name: 'home');
//       if (roleType == "partner") {
//         return const RouteSettings(name: 'partnerHome');
//       }
//     }
//     // If the user is ahave the same role, continue to the requested route
//     return null;
//   }
// }
