// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:saverapp/Screens/partner/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePartner extends StatefulWidget {
  const EditProfilePartner({Key? key}) : super(key: key);

  @override
  _EditProfilePartnerState createState() => _EditProfilePartnerState();
}

class _EditProfilePartnerState extends State<EditProfilePartner> {
  late Map<String, dynamic> user;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController categoryController;
  late TextEditingController openingtimeController;
  late TextEditingController closingtimeController;
  late TextEditingController newPasswordController;

  @override
  void initState() {
    super.initState();
    user = {};
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    categoryController = TextEditingController();
    openingtimeController = TextEditingController();
    closingtimeController = TextEditingController();
    newPasswordController = TextEditingController();
    readToken().then((token) {
      getUserInfo(token);
    });
  }

  Future<String> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '0';
  }

  Future<void> getUserInfo(dynamic token) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/partner/user');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
      final data = json.decode(response.body)['partner'];
      setState(() {
        user = data;
        nameController.text = user['name'] ?? '';
        descriptionController.text = user['description'] ?? '';
        emailController.text = user['email'] ?? '';
        phoneController.text = user['phone']?.toString() ?? '';
        categoryController.text = user['category'] ?? '';
        openingtimeController.text = user['openingtime']?.toString() ?? '';
        closingtimeController.text = user['closingtime']?.toString() ?? '';
      });
    } else {
      throw Exception('Failed to load user info');
    }
  }

  Future<void> updateUser() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/user/users/${user['id']}');
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
    final url = Uri.parse('http://10.0.2.2:8000/api/partner/changepassword');
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

    if (response.statusCode == 200) {
      setState(() {
        user = json.decode(response.body);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User Password updated successfully')),
      );
    } else {
      // print('Response status code: ${response.statusCode}');
      // print('Response body: ${response.body}');
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
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 70),
          child: Text(
            "Edit Profile",
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
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
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.description),
                      labelText: 'Description',
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
                    controller: categoryController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.store),
                      labelText: 'Category',
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
                    controller: openingtimeController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.access_time),
                      labelText: 'Opening Time',
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
                    controller: closingtimeController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.access_time_filled),
                      labelText: 'Closing Time',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[800],
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    updateUser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePartner()),
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
                    primary: Colors.green[800], // Couleur de fond du bouton
                    onPrimary: Colors.white, // Couleur du texte du bouton
                  ),
                  onPressed: () {
                    updatePassword();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePartner()),
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
