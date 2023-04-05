import 'dart:convert';
import 'package:saverapp/Models/boxs.dart';
import 'package:http/http.dart' as http;
import 'globals.dart';

class UserService {
  static Future<List<Box>> getAvailableBoxs(token) async {
    final url = Uri.parse('${baseURL}user/availableBoxs');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    // print(token);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      final box = List<Box>.from(
        data.map((boxJson) => Box.fromJson(boxJson)),
      );
      return box;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  static Future<List<Box>> getAvailableBoxsByCategorys(token, category) async {
    final url = Uri.parse('${baseURL}user/indexByCategory/$category');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    // print(token);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Box> boxs = [];
      for (var item in data["boxs"]) {
        Box box = Box.fromJson(item);
        boxs.add(box);
      }
      // print(boxs);

      return boxs;
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}
