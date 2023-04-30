// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Services/auth.dart';
import 'package:saverapp/Services/globals.dart';
import '../widget/rounded_button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalController controller = Get.find<GlobalController>();
  late String _email = '';
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // logo
              Icon(
                Icons.lock,
                size: 100,
                color: Colors.grey[500],
              ),
              const SizedBox(height: 10),

              // welcome back, you've been missed!
              Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.green.shade800, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required';
                        } else if (!isValidEmail(value)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RoundedButton(
                btnText: 'SEND EMAIL',
                onBtnPressed: () {
                  forgetPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  forgetPassword() async {
    Map<String, dynamic> response = await AuthServices.forgetPassword(_email);
    if (response["status"] == 200) {
      controller.setEmail(_email);
      // print(response);
      Get.toNamed('/verifPasswordCode');
    }
  }
}
