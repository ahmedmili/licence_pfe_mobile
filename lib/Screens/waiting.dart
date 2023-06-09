import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saverapp/Screens/welcome.dart';

import '../dimensions.dart';
import '../widget/rounded_button.dart';
import 'login.dart';

class Waiting extends StatelessWidget {
  const Waiting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 40),
            child: Text(
              "We will contact \nyou soon,\nfor more information .",
              style: GoogleFonts.bebasNeue(fontSize: 40),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              fixedSize: MaterialStateProperty.all<Size>(Size(200, 50)),
            ),
            child: Text('Take me back home'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Welcome(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
