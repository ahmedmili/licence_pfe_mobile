import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saverapp/Screens/login.dart';
import 'package:saverapp/Screens/partner/register_partner.dart';
import 'package:saverapp/Screens/user/registeruser.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 60,
          ),
          Center(
            child: Image.asset(
              "assets/images/food.png",
              width: 200,
              height: 200,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text("Welcome to SaverFood",
              style: GoogleFonts.bebasNeue(fontSize: 40)),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Let\'s take you with us !",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          RoundedButton(
            btnText: 'LOGIN',
            onBtnPressed: () => Get.to(LoginScreen()),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 60,
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.green.shade800,
                width: 2.0,
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RegisterPartnerScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      "Register As Partner",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Colors.green[800],
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RegisterUserScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      "Register As User",
                      style: TextStyle(
                          fontSize: 14,
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
    );
  }
}
