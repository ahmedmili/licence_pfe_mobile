import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:http/http.dart' as http;
import 'package:saverapp/Models/partner.dart';
import '../Models/order.dart';
import 'globals.dart';

final GlobalController controller = Get.find<GlobalController>();

class SalesData {
  SalesData(this.month, this.sales);

  final String month;
  final double sales;
}

class PartnersService {
  static Future<List<Box>> partnerBoxsbystatus(String status) async {
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

  static Future<Partner> getPartnerInfo() async {
    var token = controller.token;

    var url = Uri.parse('${baseURL}partner/user');
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

  static Future<List<Order>> getPartnerOrders(String status) async {
    try {
      final token = controller.token;
      final url = Uri.parse('${baseURL}partner/getPartnerOrders/$status');
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
            partner_name: data[i]['partner_name'],
            partner_phone: data[i]['partner_phone'],
            partner_email: data[i]['partner_email'],
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
        for (int i = 0; i < data.length; i++) {
          final newOrder = Order(
            command_id: data[i]["boxs"][0]["pivot"]["command_id"],
            partner_name: data[i]["boxs"][0]["partner"]["name"],
            partner_id: data[0]["boxs"][0]["partner"]["id"],
            partner_email: data[i]["boxs"][0]["partner"]["email"],
            partner_phone: data[i]["boxs"][0]["partner"]["phone"],
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
          orders.add(newOrder);
        }
        return orders;
      } else {
        throw Exception('Failed to fetch partner orders');
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> getPartnerBoxStats(
      String type) async {
    try {
      final token = controller.token;
      final url = Uri.parse('${baseURL}partner/salesStats/$type');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );
      List<Map<String, dynamic>> returnedData = [];
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        for (int i = 0; i < data["boxs"].length; i++) {
          String date = data["boxs"][i]["month"];
          DateTime dateTime = DateTime.parse(date);
          String monthName = DateFormat('MMMM').format(dateTime);
          // compare years and add into returned data list
          if (dateTime.year >= 2022 && dateTime.year <= DateTime.now().year) {
            returnedData.add({
              "monthName": monthName,
              "count": double.parse(data["boxs"][i]["count"].toString())
            });
          }
        }
      } else {
        throw Exception('Failed to fetch data');
      }
      return returnedData;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Partner> updatePartner(Map<String, dynamic> data) async {
    final token = controller.token;
    final url = Uri.parse('${baseURL}partner/updateData');
    final response = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: json.encode({
        'name': data["name"],
        'email': data["email"],
        'phone': data["phone"],
        'category': data["category"],
        'description': data["description"],
        'openingtime': data["openingtime"],
        'closingtime': data["closingtime"],
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'your details changed successfully');
      Get.offNamed("profilePartner");

      return json.decode(response.body);
    } else {
      Get.snackbar(
          'Error'.tr, 'Failed to changed your details. Please try again.');
      throw Exception('Failed to fetch partner data');
    }
  }

  static Future<Partner> updatePassword(password) async {
    final token = controller.token;
    final url = Uri.parse('${baseURL}partner/changepassword');
    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: json.encode({
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'your password changed successfully');
      Get.offNamed("profilePartner");
      return json.decode(response.body);
    } else {
      print(response.statusCode);
      Get.snackbar('Error'.tr, 'Failed to change password. Please try again.');
      throw Exception('Failed to fetch partner data');
    }
  }

  static Future<Partner> updatePosition(
      double lat, double long, String adress) async {
    final token = controller.token;
    final url = Uri.parse('${baseURL}partner/updatePosition');
    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: json.encode({
        "lat": lat,
        "long": long,
        "adress": adress,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'your password changed successfully');
      Get.offNamed("profilePartner");
      return json.decode(response.body);
    } else {
      print(response.statusCode);
      Get.snackbar('Error'.tr, 'Failed to change password. Please try again.');
      throw Exception('Failed to fetch partner data');
    }
  }
// update image

  static Future<void> updateImage(File image) async {
    final token = controller.token;
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    };
    final url = Uri.parse('${baseURL}partner/updateImage');
    var request = http.MultipartRequest("post", url);
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    request.headers.addAll(headers);
    var response = await request.send();
    var responseString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'your password changed successfully');
      Get.offNamed("profilePartner");
      print(responseString);
      // print("save clicked 2");
      // return json.decode(response.body);
    } else {
      print(responseString);
      // print("save clicked 3");
      // print(response.statusCode);
      Get.snackbar('Error'.tr, 'Failed to change image. Please try again.');
      throw Exception('Failed to fetch partner image');
    }
  }

  ////////////////////////////////////////////////////////
  // static Future<Map<String, dynamic>> getPartnerOrderCount() async {
  //   final token = controller.token;
  //   final url = Uri.parse('${baseURL}partner/getPartnerOrderCount');
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //       'Authorization': 'Bearer $token'
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     return data;
  //   } else {
  //     throw Exception('Failed to fetch partner order count');
  //   }
  // }
}
