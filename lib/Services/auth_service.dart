import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart';

class AuthServices {
  static Future<http.Response> register(String name, String email, String phone,
      String password, int roleId) async {
    Map data = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "roleId": roleId,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'user/register');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> registerpartner(
      String name,
      String description,
      String email,
      String phone,
      String password,
      String image,
      String category,
      String openingtime,
      String closingtime,
      int roleId) async {
    Map data = {
      "name": name,
      "description": description,
      "email": email,
      "phone": phone,
      "password": password,
      "image": image,
      "category": category,
      "openingtime": openingtime,
      "closingtime": closingtime,
      "roleId": roleId,
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}user/registerpartner');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> login(
      String email, String password, String userType) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}$userType/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }
}
