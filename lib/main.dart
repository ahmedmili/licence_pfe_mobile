import 'package:flutter/material.dart';
import 'package:saverapp/widget/foodDetails.dart';

import 'Screens/login.dart';
import 'Screens/user/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
