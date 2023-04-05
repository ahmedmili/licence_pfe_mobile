import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'globals.dart';
import 'dart:io';
import 'package:path/path.dart';

class BoxServices {
  static Future<http.Response> addBox(
      String title,
      String description,
      String oldprice,
      String newprice,
      String startdate,
      String enddate,
      String quantity,
      File image,
      String category,
      String token) async {
    var uri = Uri.parse('${baseURL}partner/boxs');
    var request = http.MultipartRequest("POST", uri);

    Map<String, String> data = {
      "title": title,
      "description": description,
      "oldprice": double.parse(oldprice).toString(),
      "newprice": double.parse(newprice).toString(),
      "startdate": DateTime.parse(startdate).toIso8601String(),
      "enddate": DateTime.parse(enddate).toIso8601String(),
      "quantity": int.parse(quantity).toString(),
      "category": category,
    };

    request.fields.addAll(data);
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    // request.files.add(multipartFile);
    request.headers.addAll({
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer $token"
    });

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    print(responseString);
    if (response.statusCode == 200) {
      return http.Response(responseString, response.statusCode);
    } else {
      throw responseString;
    }
  }
}
