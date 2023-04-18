import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:saverapp/Screens/user/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late Map<String, dynamic> user;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController newPasswordController;

  @override
  void initState() {
    super.initState();
    user = {};
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
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

  Future<void> getUserInfo(dynamic token) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/user/user');
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
      });
    } else {
      throw Exception('Failed to load user info');
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
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back),
                    const SizedBox(
                      width: 100,
                    ),
                    const Text(
                      "Edit Profile",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
              ),
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
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Name',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
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
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Phone',
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
                    updateUser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileUser()),
                    );
                  },
                  child: Text('Save Changes'),
                ),
              ),
              //change password
              const SizedBox(height: 20),
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
                      MaterialPageRoute(builder: (context) => ProfileUser()),
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
