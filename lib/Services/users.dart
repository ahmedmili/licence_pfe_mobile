import 'dart:convert';
import 'package:saverapp/Models/boxs.dart';
import 'package:http/http.dart' as http;
import 'package:saverapp/Models/partner.dart';
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
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Box> boxs = [];
      for (var item in data["boxs"]) {
        Box box = Box.fromJson(item);
        boxs.add(box);
      }
      return boxs;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  static Future<Partner> getBoxPartnerInfo(token, id) async {
    final url = Uri.parse('${baseURL}user/boxs/boxdetails/$id');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      final boxPartner = Partner.fromJson(data);
      return boxPartner;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  static Future<String> likeOrDislikeBox(token, id) async {
    final url = Uri.parse('${baseURL}user/boxs/$id/likes');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      final String message = data["message"];
      return message;
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}
