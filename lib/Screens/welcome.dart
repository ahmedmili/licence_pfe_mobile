import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saverapp/dimensions.dart';

import '../widget/rounded_button.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: DimensionS.height30 * 2),
            Center(
              child: Image.asset(
                "assets/images/food.png",
                width: DimensionS.width20 * 10,
                height: DimensionS.height20 * 10,
              ),
            ),
            SizedBox(height: DimensionS.height20),
            Text(
              "Welcome to SaverFood",
              //   style: GoogleFonts.bebasNeue(fontSize: 40),
            ),
            SizedBox(height: DimensionS.height10),
            Text(
              "Let's take you with us !",
              style: TextStyle(
                fontSize: DimensionS.font20,
              ),
            ),
            SizedBox(height: DimensionS.height50),
            RoundedButton(
              btnText: 'LOGIN',
              onBtnPressed: () => Get.toNamed("/login"),
            ),
            SizedBox(height: DimensionS.height30),
            Container(
              height: DimensionS.height30 * 2,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DimensionS.radius20),
                border: Border.all(
                  color: Colors.green.shade800,
                  width: DimensionS.width10 / 5,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed("/registerPartner"),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        "Register As Partner",
                        style: TextStyle(
                            fontSize: DimensionS.font28 / 2,
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.green[800],
                    width: DimensionS.width20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/registerUser");
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: DimensionS.width10),
                      child: Text(
                        "Register As User",
                        style: TextStyle(
                            fontSize: DimensionS.font28 / 2,
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
