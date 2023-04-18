import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:saverapp/Screens/change_password.dart';
import 'package:saverapp/Screens/forgetPassword.dart';
import 'package:saverapp/Services/globals.dart';

import '../widget/codeBox.dart';
import '../widget/rounded_button.dart';

class Code extends StatefulWidget {
  const Code({super.key});

  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {
  List<FocusNode> focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (FocusNode focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalController controller = Get.find<GlobalController>();
    print(controller.email);
    List<CodeBox> codeBoxes = List.generate(
      4,
      (index) => CodeBox(
        key: Key(index.toString()),
        moveCount: index,
        focusNode: focusNodes[index],
        onTextChanged: (text) {
          if (text.length == 1 && index < 5) {
            focusNodes[index + 1].requestFocus();
          }
        },
      ),
    );
    return Container(
      height: 2000,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.grey,
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Verification CODE",
                    style: GoogleFonts.bebasNeue(fontSize: 50)),
                const SizedBox(height: 20),
                const Text(
                  "Enter the verification code sent at your email",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: codeBoxes,
                  ),
                ),
                const SizedBox(height: 20),
                RoundedButton(
                  btnText: 'SEND CODE',
                  onBtnPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ChangePassword(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ForgetPassword(),
                        ));
                  },
                  child: const Text(
                    'Resend email ?',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
