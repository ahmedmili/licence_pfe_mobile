import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:slide_to_act/slide_to_act.dart';

class PassOrder extends StatefulWidget {
  const PassOrder({super.key});

  @override
  State<PassOrder> createState() => _PassOrderState();
}

class _PassOrderState extends State<PassOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green[800],
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
                    top: 430 - 20,
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Order To Be Picked Up",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[800]),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.close,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: const [
                                  Expanded(
                                    child: Text(
                                      'Validate below and show the screen to the merchant.\nMake sure to confirm only when you are at the merchant\'s shop to collect your box.',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SlideAction(
                                  borderRadius: 20,
                                  elevation: 0,
                                  innerColor: Colors.green[800],
                                  outerColor: Colors.grey[300],
                                  sliderButtonIcon: const Icon(
                                    CupertinoIcons.cube_box,
                                    color: Colors.white,
                                  ),
                                  text: 'Box received',
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                      fontSize: 24),
                                  sliderRotate: false,
                                  onSubmit: () {
                                    //do simething
                                  },
                                ),
                              ),
                              Text(
                                "The merchant must swipe to validate .",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.orange[900]),
                              )
                            ],
                          ),
                        ],
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
