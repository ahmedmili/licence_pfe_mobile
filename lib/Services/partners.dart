import 'dart:convert';
import 'package:get/get.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:http/http.dart' as http;
import 'package:saverapp/Models/partner.dart';
import 'globals.dart';

final GlobalController controller = Get.find<GlobalController>();

class PartnersService {
  static Future<List<Box>> getPartnerBoxes() async {
    final token = controller.token;
    if (token == null) {
      throw Exception('Token is null');
    }
    final url = Uri.parse('${baseURL}partner/partnerboxes');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        if (token != null) 'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List<dynamic>) {
        final box = List<Box>.from(
          data.map((boxJson) => Box.fromJson(boxJson)),
        );
        return box;
      } else if (data is Map<String, dynamic>) {
        final box = Box.fromJson(data);
        return [box];
      } else {
        throw Exception('Failed to fetch partner boxes');
      }
    } else {
      throw Exception('Failed to fetch partner boxes');
    }
  }
}
