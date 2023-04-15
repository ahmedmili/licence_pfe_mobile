import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../widget/partnerDetails.dart';
import 'congratulations.dart';

class PassOrder extends StatefulWidget {
  const PassOrder({super.key});

  @override
  State<PassOrder> createState() => _PassOrderState();
}

class _PassOrderState extends State<PassOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Afficher l'image de fond floue
          Positioned.fill(
            bottom: 250,
            child: Image.asset(
              "assets/images/food.png",
              height: 2,
              width: 10,
              // fit: BoxFit.cover,
            ),
          ),
          // Appliquer le flou sur l'image de fond
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 400 - 20,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
