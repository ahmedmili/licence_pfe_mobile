import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {}

  @override
  void initState() {
    super.initState();
    _loadResource();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(const Duration(seconds: 4), () => Get.offNamed('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        ScaleTransition(
          scale: animation,
          child: Center(
            child: Image.asset(
              "assets/images/logo.png",
              width: Dimensions.width20 * 35,
              height: Dimensions.height20 * 25,
            ),
          ),
        ),
        Center(
          child: Text(
            "SOUSSE , TUNISIE",
            style: TextStyle(
                color: Colors.green.shade800,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }
}
