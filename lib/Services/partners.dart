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
    final url = Uri.parse('${baseURL}partner/partnerboxes');
    print(token);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      final box = List<Box>.from(
        data.map((boxJson) => Box.fromJson(boxJson)),
      );

      return box;
    } else {
      throw Exception('Failed to fetch partner boxes');
    }
  }
}
