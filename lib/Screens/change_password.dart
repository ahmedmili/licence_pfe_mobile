import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:saverapp/Screens/login.dart';

import '../Services/globals.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late TextEditingController newPasswordController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    newPasswordController = TextEditingController();
  }

  Future<void> updatePassword() async {
    final String email = Get.arguments;
    final password = newPasswordController.text;

    // Send a PUT request to the backend to update the password
    final response = await http.put(
      Uri.parse('${baseURL}user/passwordeux'),
      body: {
        'email': email,
        'password': password,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      // Password updated successfully, show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully')),
      );
    } else {
      // Password update failed, show an error message
      final errorMessage = response.body;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 40),
          child: Text(
            "New Password",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 2000,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //change password
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Change Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green[800]),
                ),
              ),
              const SizedBox(height: 20),
              // Container(
              //   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              //   child: Material(
              //     elevation: 5.0,
              //     borderRadius: BorderRadius.circular(20.0),
              //     child: TextFormField(
              //       controller: emailController,
              //       decoration: const InputDecoration(
              //         contentPadding: EdgeInsets.symmetric(
              //             horizontal: 30.0, vertical: 14.0),
              //         prefixIcon: Icon(Icons.lock),
              //         labelText: 'Email',
              //         border: InputBorder.none,
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'New password',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[800], // Couleur de fond du bouton
                    onPrimary: Colors.white, // Couleur du texte du bouton
                  ),
                  onPressed: () {
                    updatePassword();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text('Save Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
