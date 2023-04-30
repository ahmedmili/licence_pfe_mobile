import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:saverapp/Services/auth.dart';

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
    final List verifCodeList = ["", "", "", ""];
    verifCode() async {
      var code = verifCodeList.join("");
      if (code.isEmpty) {
        Get.snackbar(
          backgroundColor: const Color.fromRGBO(243, 75, 63, 0.644),
          "error",
          "please fill the code area",
        );
      } else {
        var response = await AuthServices.sendVerifCode(code);
        if (response["response"]?["status"] == 200) {
          Get.snackbar("success", response["response"]["message"],
              backgroundColor: const Color.fromARGB(255, 38, 209, 44));
          Get.toNamed("changePassword");
          // print(response["response"]["message"]);
        } else {
          Get.snackbar(
            backgroundColor: const Color.fromRGBO(243, 75, 63, 0.644),
            "error",
            "error pls try again",
          );
        }
      }
    }

    // print(controller.email);
    List<CodeBox> codeBoxes = List.generate(
      4,
      (index) => CodeBox(
        key: Key(index.toString()),
        moveCount: index,
        focusNode: focusNodes[index],
        onTextChanged: (text) {
          verifCodeList[index] = text;
          if (text.length == 1 && index < 5) {
            focusNodes[index + 1].requestFocus();
          }
        },
      ),
    );
    return SizedBox(
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
                    verifCode();
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
