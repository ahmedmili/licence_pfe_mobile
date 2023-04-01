import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/partners_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BoxScreen extends StatefulWidget {
  const BoxScreen({Key? key}) : super(key: key);

  @override
  State<BoxScreen> createState() => _BoxScreenState();
}

class _BoxScreenState extends State<BoxScreen> {
  late String token;
  @override
  void initState() {
    super.initState();
    readToken();
  }

  Future<void> getPartnerBoxs() async {
    try {
      http.Response response = await PartnersService.getBoxs(token);
      List<dynamic> responseList = jsonDecode(response.body);
      for (var responseMap in responseList) {
        // print(responseMap);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? "0";
    });
    await getPartnerBoxs(); // Appeler getPartnerBoxs() comme Future
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Boxs")),
    );
  }
}
