import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:saverapp/Services/geoLocator.dart';

import '../dimensions.dart';
import 'forgetPassword.dart';

import '../Services/auth.dart';
import '../Services/globals.dart';
import '../widget/rounded_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalController controller = Get.find<GlobalController>();
  final GeoLocatorController geoController = Get.find<GeoLocatorController>();
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
          controller.setRole(role);
          controller.setToken(token);
          _save(token, role);
          if (token.isNotEmpty) {
            Get.offAllNamed('/main');
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
          controller.setRole(role);
          controller.setToken(token);
          _save(token, role);

          if (token.isNotEmpty) {
            // Get.toNamed("/main");
            Get.offAllNamed('/partnerMain');

            // Get.back();
            return;
          }
        }
      } catch (e) {
        // Catch any errors and handle appropriately
        // print("Error: $e");
      }

      // If we reach this point, both login attempts have failed
      Get.snackbar("Error".tr, "Invalid email or password");
    } else {
      Get.snackbar("Error".tr, "enter all required fields");
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
    bool _obscureText = true;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(30),
              children: [
                Column(
                  children: [
                    Text("login_hello".tr,
                        style: GoogleFonts.bebasNeue(fontSize: 52)),
                    SizedBox(height: Dimensions.height10),
                    Text(
                      "login_slog".tr,
                      style: TextStyle(
                        fontSize: Dimensions.font20,
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
                            return 'email_requied'.tr;
                          } else if (!isValidEmail(value)) {
                            return 'email_invalid_format'.tr;
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
                SizedBox(height: Dimensions.height10),
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
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password'.tr,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password_required'.tr;
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
                SizedBox(height: Dimensions.height10),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) =>
                    //         const ForgetPassword(),
                    //   ),
                    // );
                    Get.toNamed("forgetPassword");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 200.0),
                    child: Text(
                      'forget_passsword_question'.tr,
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RoundedButton(
                  btnText: ('login'.tr).toUpperCase(),
                  onBtnPressed: () => loginPressed(context),
                ),
                const SizedBox(
                  height: 30,
                ),
                // or continue with
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                // Expanded(
                //   child: Divider(
                //     thickness: 0.5,
                //     color: Colors.grey[400],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //   child: Text(
                //     'or_continue_message'.tr,
                //     style: TextStyle(color: Colors.grey[700]),
                //   ),
                // ),
                // Expanded(
                //   child: Divider(
                //     thickness: 0.5,
                //     color: Colors.grey[400],
                //   ),
                // ),
                //     ],
                //   ),
                // ),

                // const SizedBox(height: 30),

                // ElevatedButton(
                //   onPressed: () {},
                //   style: ElevatedButton.styleFrom(
                //     foregroundColor: Colors.black87,
                //     backgroundColor: Colors.white,
                //     minimumSize: const Size(double.infinity, 60.0),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Image.asset(
                //         'assets/images/google_logo.png',
                //         height: 24.0,
                //       ),
                //       const SizedBox(width: 8.0),
                //       const Text('Sign in with Google'),
                //     ],
                //   ),
                // ),

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
