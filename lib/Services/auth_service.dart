import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart';
import 'dart:io';
import 'package:path/path.dart';

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
    // var stream = http.ByteStream(image.openRead());
    // var length = await image.length();
    var uri = Uri.parse('${baseURL}user/registerpartner');
    var request = http.MultipartRequest("POST", uri);

    // ignore: unnecessary_new
    // var multipartFile = new http.MultipartFile('image', stream, length,
    //     filename: basename(image.path));

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
    // request.files.add(multipartFile);
    request.headers.addAll(headers);

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    print(responseString);
    if (response.statusCode == 200) {
      return http.Response(responseString, response.statusCode);
    } else {
      throw responseString;
      // throw Exception('Failed to load data from API');
    }
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
