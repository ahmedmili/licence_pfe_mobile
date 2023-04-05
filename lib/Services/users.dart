import 'dart:convert';
import 'package:saverapp/Models/boxs.dart';
import 'package:http/http.dart' as http;
import 'globals.dart';

class PartnersService {
  static Future<List<Box>> getBoxs(token) async {
    final url = Uri.parse('${baseURL}user/boxs');
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
}
