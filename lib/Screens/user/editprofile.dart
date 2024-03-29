// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saverapp/Screens/user/profile.dart';
import 'package:saverapp/Services/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late Map<String, dynamic> user;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController birthdayController;
  late TextEditingController sexeController;
  late TextEditingController newPasswordController;

  @override
  void initState() {
    super.initState();
    user = {};
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    birthdayController = TextEditingController();
    sexeController = TextEditingController();
    newPasswordController = TextEditingController();
    readToken().then((token) {
      getUserInfo(token);
    });
  }

  Future<String> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '0';
  }

  Future<void> updateUser() async {
    final url = Uri.parse('${baseURL}user/users/${user['id']}');
    final token = await readToken();
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'name': nameController.text,
        'email': emailController.text,
        'phone': int.parse(phoneController.text),
        'birthday': int.parse(birthdayController.text),
        'sexe': int.parse(sexeController.text),
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        user = json.decode(response.body);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User details updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update user details. Please try again.'),
        ),
      );
    }
  }

  Future<void> updatePassword() async {
    final url = Uri.parse('${baseURL}user/user/password');
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

      Get.snackbar("success", 'User Password updated successfully');
    } else {
      Get.snackbar("error", 'Failed to update user details. Please try again.');
    }
  }

  Future<void> getUserInfo(dynamic token) async {
    final url = Uri.parse('${baseURL}user/user');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        user = data;
        nameController.text = user['name'] ?? '';
        emailController.text = user['email'] ?? '';
        phoneController.text = user['phone']?.toString() ?? '';
        birthdayController.text = user['birthday']?.toString() ?? '';
        sexeController.text = user['sexe']?.toString() ?? '';
      });
    } else {
      throw Exception('Failed to load user info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 65),
          child: Text(
            "Edit Profile",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),

              Text(
                "My Account Details ",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green[800]),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Name',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Phone',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: birthdayController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.cake),
                      labelText: 'Birthday',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: sexeController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Sexe',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green[800],
                  ),
                  onPressed: () {
                    updateUser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileUser()),
                    );
                  },
                  child: const Text('Save Changes'),
                ),
              ),
              //change password
              const SizedBox(height: 20),
              Text(
                "Change Password",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green[800]),
              ),
              const SizedBox(height: 20),
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
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Colors.green[800], // Couleur du texte du bouton
                  ),
                  onPressed: () {
                    updatePassword();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileUser()),
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
