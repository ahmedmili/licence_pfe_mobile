import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:saverapp/Screens/user/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late Map<String, dynamic> user;

  late TextEditingController newPasswordController;

  get http => null;

  @override
  void initState() {
    super.initState();
    user = {};

    newPasswordController = TextEditingController();
    readToken().then((token) {});
  }

  Future<String> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '0';
  }

  Future<void> updatePassword() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/user/user/password');
    final token = await readToken();
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'password': newPasswordController.text,
      }),
    );

    if (response.statusCode == 202) {
      setState(() {
        user = json.decode(response.body);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User Password updated successfully')),
      );
    } else {
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update user details. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),

              Row(
                children: [
                  const SizedBox(
                    width: 120,
                  ),
                  const Text(
                    "New Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),

              //change password
              const SizedBox(height: 100),
              Text(
                "Change Password",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green[800]),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
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
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  child: Text('Save Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
