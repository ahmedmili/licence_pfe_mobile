import 'dart:convert';
import 'package:flutter/material.dart';
import '../Services/auth_service.dart';
import '../Services/globals.dart';
import '../rounded_button.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class RegisterPartnerScreen extends StatefulWidget {
  const RegisterPartnerScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterPartnerScreen> {
  String _name = '';
  String _description = '';
  String _email = '';
  String _phone = '';
  String _password = '';
  String _image = '';
  String _category = '';
  TimeOfDay _openingtime = TimeOfDay(hour: 8, minute: 30);
  TimeOfDay _closingtime = TimeOfDay(hour: 9, minute: 30);
  final int _roleId = 3;

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _openingtime = value!;
      });
    });
  }

  void _showClosingTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _closingtime = value!;
      });
    });
  }

  List<String> categories = [
    '',
    'SUPERMARKET',
    'BAKERY',
    'PASTRIES',
    'RESTAURANT',
    'COFFEE SHOP',
    'HOTEL',
    'CATERER',
    'LOCAL PRODUCERS'
  ];

  Future<void> createAccountPressed() async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
    if (emailValid) {
      http.Response response = await AuthServices.registerpartner(
          _name,
          _description,
          _email,
          _phone,
          _password,
          _image,
          _category,
          _openingtime.format(context),
          _closingtime.format(context),
          _roleId);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen(),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first[0]);
      }
    } else {
      errorSnackBar(context, 'email not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Registration',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
              onChanged: (value) {
                _name = value;
              },
            ),

            TextField(
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
              onChanged: (value) {
                _description = value;
              },
            ),

            TextField(
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              onChanged: (value) {
                _email = value;
              },
            ),

            TextField(
              decoration: const InputDecoration(
                hintText: 'Phone',
              ),
              onChanged: (value) {
                _phone = value;
              },
            ),

            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Image',
              ),
              onChanged: (value) {
                _image = value;
              },
            ),
            // Utilisez un DropdownButtonFormField pour sélectionner la catégorie
            Text(
              'Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            DropdownButtonFormField(
              value: _category,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _category = value as String;
                });
              },
            ),
            Text(
              _openingtime.format(context).toString(),
              style: TextStyle(fontSize: 10),
            ),

            // button
            MaterialButton(
              onPressed: _showTimePicker,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('PICK TIME',
                    style: TextStyle(color: Colors.white, fontSize: 5)),
              ),
              color: Colors.blue,
            ),

            Text(
              _closingtime.format(context).toString(),
              style: TextStyle(fontSize: 10),
            ),

            // button
            MaterialButton(
              onPressed: _showClosingTimePicker,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('PICK TIME',
                    style: TextStyle(color: Colors.white, fontSize: 5)),
              ),
              color: Colors.blue,
            ),

            RoundedButton(
              btnText: 'Create Account',
              onBtnPressed: () => createAccountPressed(),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const LoginScreen(),
                    ));
              },
              child: const Text(
                'already have an account',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
