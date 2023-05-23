import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/routes.dart';

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
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ScaleTransition(
          scale: animation,
          child: Center(
            child: Image.asset(
              "assets/images/food.png",
              // width: Dimensions.splashImg,
            ),
          ),
        ),
        Center(
          child: Image.asset(
            "assets/images/name.png",
            // width: Dimensions.splashImg,
          ),
        ),
      ]),
    );
  }
}
