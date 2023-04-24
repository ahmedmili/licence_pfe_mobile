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
    // print(token);
    final url = Uri.parse('${baseURL}partner/getPartnerBoxs');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)["Boxs"];
      final List<Box> box = [];
      for (int i = 0; i < data.length; i++) {
        final newBox = Box(
          // Add fields here to create the new Box object
          id: data[i]['id'],
          description: data[i]['description'],
          category: data[i]['category'],
          newprice: data[i]['newprice'],
          startdate: data[i]['startdate'],
          enddate: data[i]['enddate'],
          quantity: data[i]['quantity'],
          remaining_quantity: data[i]['remaining_quantity'],
          image: data[i]['image'],
          partnerId: data[i]['partner_id'],
          title: data[i]['title'],
          oldprice: data[i]['oldprice'],
        );

        box.add(newBox);
      }
      return box;
    } else {
      throw Exception('Failed to fetch partner boxes');
    }
  }
}
