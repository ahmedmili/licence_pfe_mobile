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
    return response;
  }

  static Future<Map> registerpartner(
    String name,
    String description,
    String email,
    String phone,
    String password,
    File image,
    String category,
    String openingtime,
    String closingtime,
    int roleId,
    double long,
    double lat,
    String adress,
  ) async {
    var uri = Uri.parse('${baseURL}user/registerpartner');
    var request = http.MultipartRequest("POST", uri);
    print("---------------------");

    Map<String, String> data = {
      "name": name,
      "description": description,
      "email": email,
      "phone": phone,
      "password": password,
      "category": category,
      "openingtime": openingtime,
      "closingtime": closingtime,
      "long": long.toString(),
      "lat": lat.toString(),
      "adress": adress,
      "roleId": roleId.toString(),
    };

    request.fields.addAll(data);
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    request.headers.addAll(headers);

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      if (jsonDecode(responseString)["status"] == 400) {
        return {
          "error": jsonDecode(responseString)["0"],
          "status": jsonDecode(responseString)["status"]
        };
      } else if (jsonDecode(responseString)['status'] == 201) {
        // print(jsonDecode(responseString));
        return {
          "message": jsonDecode(responseString)['message'],
          "status": jsonDecode(responseString)['status'],
        };
      } else {
        throw responseString;
      }
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
      print(response.statusCode);
      // responseMessage = {
      //   "response": json.decode(response.body),
      //   "status": response.statusCode
      // };
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
