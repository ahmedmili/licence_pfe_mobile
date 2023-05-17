import 'dart:convert';
import 'package:get/get.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:http/http.dart' as http;
import 'package:saverapp/Models/partner.dart';
import '../Models/order.dart';
import 'globals.dart';

final GlobalController controller = Get.find<GlobalController>();

class PartnersService {
  static Future<List<Box>> PartnerBoxsbystatus(String status) async {
    final token = controller.token;
    final url = Uri.parse('${baseURL}partner/getPartnerBoxsbystatus/$status');
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

//logout
  static Future<http.Response> logout() async {
    var token = controller.token;
    var url = Uri.parse('${baseURL}partner/logout');
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

  static Future<Partner> getUserInfo() async {
    var token = controller.token;

    var url = Uri.parse('$baseURL/partner/user');
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)["partner"];
      final partner = Partner(
        // Add fields here to create the new Box object
        id: data['id'],
        name: data['name'],
        description: data['description'],
        category: data['category'],
        email: data['email'],
        phone: data['phone'],
        openingtime: data['openingtime'],
        closingtime: data['closingtime'],
        image: data['image'],
        lat: data['lat'],
        long: data['long'],
        adress: data['adress'],
      );
      return partner;
    } else {
      throw Exception('Failed to load user info');
    }
  }

  static Future<List<Order>> getPartnerOrders() async {
    try {
      final token = controller.token;
      final url = Uri.parse('${baseURL}partner/getPartnerOrders');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<Order> orders = [];
        for (int i = 0; i < data.length; i++) {
          final newOrder = Order(
            partner_id: data[i]['partner_id'],
            command_id: data[i]['command_id'],
            user_name: data[i]['user_name'],
            user_email: data[i]['user_email'],
            user_phone: data[i]['user_phone'],
            box_name: data[i]['box_name'],
            box_category: data[i]['box_category'],
            box_description: data[i]['box_description'],
            box_startdate: data[i]['box_startdate'],
            box_enddate: data[i]['box_enddate'],
            quantity: data[i]['quantity'],
            box_image: data[i]['box_image'],
            oldprice: data[i]['oldprice'],
            newprice: data[i]['newprice'],
            price: data[i]['price'],
            remaining_quantity: data[i]['remaining_quantity'],
            created_at: data[i]['created_at'],
          );
          orders.add(newOrder);
        }
        return orders;
      } else {
        throw Exception('Failed to fetch partner orders');
      }
    } catch (error) {
      print('Error fetching partner orders: $error');
      rethrow; // Propagate the error
    }
  }

  static Future<List<Order>> getUserOrders(String status) async {
    try {
      final token = controller.token;
      final url = Uri.parse('${baseURL}user/getUserOrders/$status');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<Order> orders = [];
        // print(data[0]['boxs'][0]["title"]);
        // print(data[0]["user"]["id"]);
        for (int i = 0; i < data.length; i++) {
          // print(i);
          final newOrder = Order(
            command_id: data[i]["boxs"][0]["pivot"]["command_id"],
            user_name: data[i]["user"]["name"],
            user_email: data[i]["user"]["email"],
            user_phone: data[i]["user"]["phone"],
            box_name: data[i]['boxs'][0]["title"],
            box_category: data[i]["boxs"][0]["category"],
            box_description: data[i]["boxs"][0]["description"],
            box_startdate: data[i]["boxs"][0]["startdate"],
            box_enddate: data[i]["boxs"][0]["enddate"],
            quantity: data[i]["boxs"][0]["pivot"]["quantity"],
            box_image: data[i]["boxs"][0]["image"],
            oldprice: data[i]["boxs"][0]["oldprice"],
            newprice: data[i]["boxs"][0]["newprice"],
            price: data[i]["price"],
            remaining_quantity: data[i]["boxs"][0]['remaining_quantity'],
            created_at: data[i]['created_at'],
          );
          // print(newOrder.box_category);
          orders.add(newOrder);
        }
        return orders;
      } else {
        throw Exception('Failed to fetch partner orders');
      }
    } catch (error) {
      print('Error fetching partner orders: $error');
      rethrow;
    }
  }
}
