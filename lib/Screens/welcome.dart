import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saverapp/dimensions.dart';

import '../widget/rounded_button.dart';
import '../widget/translate.dart';

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
            SizedBox(height: Dimensions.height30 * 2),
            Center(
              child: Image.asset(
                "assets/images/food.png",
                width: Dimensions.width20 * 10,
                height: Dimensions.height20 * 10,
              ),
            ),
            SizedBox(height: Dimensions.height20),
            Text(
              // "Welcome to SaverFood",
              "greeting".tr,
              style: GoogleFonts.bebasNeue(fontSize: 40),
            ),
            SizedBox(height: Dimensions.height10),
            Text(
              // "Let's take you with us !",
              "greeting_message".tr,
              style: TextStyle(
                fontSize: Dimensions.font20,
              ),
            ),
            SizedBox(height: Dimensions.height50),
            RoundedButton(
              btnText: 'login'.tr,
              onBtnPressed: () => Get.toNamed("/login"),
            ),
            SizedBox(height: Dimensions.height30),
            Container(
              height: Dimensions.height30 * 2,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                border: Border.all(
                  color: Colors.green.shade800,
                  width: Dimensions.width10 / 5,
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
                        "register_partner".tr,
                        style: TextStyle(
                            fontSize: Dimensions.font28 / 2,
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.green[800],
                    width: Dimensions.width20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/registerUser");
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: Dimensions.width10),
                      child: Text(
                        "register_user".tr,
                        style: TextStyle(
                            fontSize: Dimensions.font28 / 2,
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const LanguageSwitchDropdown(),
          ],
        ),
      ),
    );
  }
}
