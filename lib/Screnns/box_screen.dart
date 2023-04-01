import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/partners_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BoxScreen extends StatefulWidget {
  const BoxScreen({super.key});

  @override
  State<BoxScreen> createState() => _BoxScreenState();
}

class _BoxScreenState extends State<BoxScreen> {
  late String token;
  @override
  void initState() {
    super.initState();
    readToken();
    // getPartnerBoxs();
  }

  getPartnerBoxs() async {
    http.Response response = await PartnersService.getBoxs(token);
    Map responseMap = jsonDecode(response.body);
    print(responseMap);
  }

  Future<void> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    getPartnerBoxs();
    return Container(
      child: Center(child: Text("Boxs")),
    );
  }
}
