import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'globals.dart';
import 'dart:io';

final GlobalController controller = Get.find<GlobalController>();

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
    var url = Uri.parse('${baseURL}user/register');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    // print(response.body);
    return response;
  }

  static Future<http.Response> registerpartner(
      String name,
      String description,
      String email,
      String phone,
      String password,
      File image,
      String category,
      String openingtime,
      String closingtime,
      int roleId) async {
    var uri = Uri.parse('${baseURL}user/registerpartner');
    var request = http.MultipartRequest("POST", uri);

    Map<String, String> data = {
      "name": name,
      "description": description,
      "email": email,
      "phone": phone,
      "password": password,
      "category": category,
      "openingtime": openingtime,
      "closingtime": closingtime,
      "roleId": roleId.toString(),
    };

    request.fields.addAll(data);
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    request.headers.addAll(headers);

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return http.Response(responseString, response.statusCode);
    } else {
      throw responseString;
    }
  }

  static Future<http.Response> login(
      String email, String password, String userType) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse('$baseURL$userType/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }

  static Future<http.Response> logout() async {
    var token = controller.token;
    var url = Uri.parse('${baseURL}user/logout');
    http.Response response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.body.isNotEmpty) {}
    return response;
  }

  static Future<Map<String, dynamic>> forgetPassword(String email) async {
    String email0 = email;
    late Map<String, dynamic> responseMessage;
    var body = json.encode({"email": email0});
    final url = Uri.parse('${baseURL}forgetPassWord');
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      responseMessage = {
        "response": json.decode(response.body),
        "status": response.statusCode
      };
    } else {
      responseMessage = {
        "response": json.decode(response.body),
        "status": response.statusCode
      };
    }
    return responseMessage;
  }

  static Future<Map<String, dynamic>> sendVerifCode(String verifCode) async {
    var email = controller.email;

    late Map<String, dynamic> responseMessage;
    var body = json.encode({
      "code": verifCode,
      "email": email,
    });
    final url = Uri.parse('${baseURL}verifCode');
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      responseMessage = {
        "response": json.decode(response.body),
      };
    } else {
      responseMessage = {"status": response.statusCode};
    }
    return responseMessage;
  }
}
