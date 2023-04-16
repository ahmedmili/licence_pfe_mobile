import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:saverapp/Screens/user/main_page.dart';
import 'forgetPassword.dart';
import 'partner/register_partner.dart';
import 'user/registeruser.dart';
import '../Services/auth.dart';
import '../Services/globals.dart';
import '../widget/rounded_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'partner/home_partner.dart' as partner_home;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // 1
  String _email = '';
  String _password = '';
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> loginPressed(BuildContext context) async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      if (!isValidEmail(_email)) {
        errorSnackBar(context, 'Invalid email');
        return;
      }

      try {
        // Try to login as user
        http.Response response =
            await AuthServices.login(_email, _password, 'user');
        Map responseMap = jsonDecode(response.body);

        if (response.statusCode == 200) {
          // Login successful, navigate to HomeScreen
          String token = responseMap['token'];
          String role = responseMap['role'];
          _save(token, role);
          if (token.isNotEmpty) {
            Get.toNamed('/main');
            return;
          }
        }
      } catch (e) {
        // Catch any errors and move on to the next attempt
        // print("Error: $e");
      }

      try {
        // Try to login as partner
        http.Response response =
            await AuthServices.login(_email, _password, 'partner');
        Map responseMap = jsonDecode(response.body);
        if (response.statusCode == 200) {
          // Login successful as partner, navigate to PartnerScreen

          String token = responseMap['token'];
          String role = responseMap['role'];
          _save(token, role);

          if (token.isNotEmpty) {
            Get.toNamed("/partnerHome");
            // Get.back();
            return;
          }
        }
      } catch (e) {
        // Catch any errors and handle appropriately
        // print("Error: $e");
      }

      // If we reach this point, both login attempts have failed
      errorSnackBar(context, 'Invalid email or password');
    } else {
      errorSnackBar(context, 'enter all required fields');
    }
  }

  _save(String token, String role) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    prefs.setString("role", role);
    prefs.setBool("firstLogin", false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(30),
              children: [
                Column(
                  children: [
                    Text("HELLO AGAIN !",
                        style: GoogleFonts.bebasNeue(fontSize: 52)),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Welcome back , you\'ve been missed !",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border:
                          Border.all(color: Colors.green.shade800, width: 2),
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
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border:
                          Border.all(color: Colors.green.shade800, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _password = value;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ForgetPassword(),
                        ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 220.0),
                    child: Text(
                      'Forget Password ?',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RoundedButton(
                  btnText: 'LOGIN',
                  onBtnPressed: () => loginPressed(context),
                ),
                const SizedBox(
                  height: 30,
                ),
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 60.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google_logo.png',
                        height: 24.0,
                      ),
                      const SizedBox(width: 8.0),
                      const Text('Sign in with Google'),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
