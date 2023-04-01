import 'dart:convert';

import 'package:http/http.dart' as http;
import 'globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

// read() async {
//   final prefs = await SharedPreferences.getInstance();
//   final String value = prefs.getString("token") ?? "0";
//   return value;
// }

class PartnersService {
  static Future<http.Response> getBoxs(token) async {
    // final prefs = await SharedPreferences.getInstance();
    // final String value = prefs.getString("token") ?? "0";
    var url = Uri.parse('${baseURL}partner/boxs');
    // print(value);
    http.Response response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    return response;
  }
}
