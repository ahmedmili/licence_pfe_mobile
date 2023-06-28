import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Models/boxs.dart';
import 'globals.dart';
import 'dart:io';

final GlobalController controller = Get.find<GlobalController>();

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
    //print(response.statusCode);
    if (response.statusCode == 200) {
      return http.Response(responseString, response.statusCode);
    } else {
      throw Exception('Erreur lors de la requête : ${response.statusCode}');
    }
  }

  static Future<void> updateBoxImage(File image, int id) async {
    final token = controller.token;

    var uri = Uri.parse('${baseURL}partner/updateBoxImage/$id');
    var request = http.MultipartRequest("POST", uri);

    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    request.headers.addAll({
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer $token"
    });
    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    //print(response.statusCode);
    if (response.statusCode == 200) {
      // return http.Response(responseString, response.statusCode);
      final data = jsonDecode(responseString)["box_info"];
      // print(data);
      Box box = Box(
        title: data['title'],
        category: data['category'],
        description: data['description'],
        enddate: data['enddate'],
        id: data['id'],
        image: data['image'],
        newprice: data['newprice'],
        oldprice: data["oldprice"],
        partnerId: data["partner_id"],
        quantity: data["quantity"],
        remaining_quantity: data['remaining_quantity'],
        startdate: data['startdate'],
      );
      controller.setBox(box);
      Get.toNamed('/boxdetails');
      print(jsonDecode(responseString)["message"]);
    } else {
      throw Exception('Erreur lors de la requête : ${response.statusCode}');
    }
  }

  static Future<void> updateBoxDetails(
    int id,
    String title,
    String description,
    String oldprice,
    String newprice,
    String startdate,
    String enddate,
    String quantity,
    String category,
  ) async {
    final token = controller.token;

    var uri = Uri.parse('${baseURL}partner/updateBoxDetails/$id');

    final response = await http.put(
      uri,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: json.encode({
        "title": title,
        "description": description,
        "oldprice": oldprice,
        "newprice": newprice,
        "startdate": DateTime.parse(startdate).toIso8601String(),
        "enddate": DateTime.parse(enddate).toIso8601String(),
        "quantity": int.parse(quantity).toString(),
        "category": category,
      }),
    );
    Box box = Box(
      title: jsonDecode(response.body)["box"]['title'],
      category: jsonDecode(response.body)["box"]['category'],
      description: jsonDecode(response.body)["box"]['description'],
      enddate: jsonDecode(response.body)["box"]['enddate'],
      id: jsonDecode(response.body)["box"]['id'],
      image: jsonDecode(response.body)["box"]['image'],
      newprice: jsonDecode(response.body)["box"]['newprice'],
      oldprice: jsonDecode(response.body)["box"]["oldprice"],
      partnerId: jsonDecode(response.body)["box"]["partner_id"],
      quantity: int.parse(jsonDecode(response.body)["box"]["quantity"]),
      remaining_quantity:
          int.parse(jsonDecode(response.body)["box"]['remaining_quantity']),
      startdate: jsonDecode(response.body)["box"]['startdate'],
    );
    controller.setBox(box);
    if (response.statusCode == 200) {
      Get.snackbar(
          backgroundColor: Colors.white,
          'Success',
          'box details changed successfully',
          colorText: Colors.green.shade800);
      // Get.back();
      Get.toNamed('/boxdetails');
    } else {
      Get.snackbar(
          backgroundColor: Colors.red,
          'Error'.tr,
          'Failed to changed box details. Please try again.',
          colorText: Colors.white);
      throw Exception('Failed to fetch partner data');
    }
  }
}
