import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:saverapp/Screnns/registerpartner_screen.dart';
import 'package:saverapp/Screnns/registeruser_screen.dart';
import '../Services/auth_service.dart';
import '../Services/globals.dart';
import '../rounded_button.dart';
import 'home_screen.dart';

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
          if (token != null && token.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomeScreen()),
            );
            return;
          }
        }
      } catch (e) {
        // Catch any errors and move on to the next attempt
        print("Error: $e");
      }

      try {
        // Try to login as partner
        http.Response response =
            await AuthServices.login(_email, _password, 'partner');
        Map responseMap = jsonDecode(response.body);

        if (response.statusCode == 200) {
          // Login successful as partner, navigate to PartnerScreen
          String token = responseMap['token'];
          if (token != null && token.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomeScreen()),
            );
            return;
          }
        }
      } catch (e) {
        // Catch any errors and handle appropriately
        print("Error: $e");
      }

      // If we reach this point, both login attempts have failed
      errorSnackBar(context, 'Invalid email or password');
    } else {
      errorSnackBar(context, 'enter all required fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: 'Email',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black))),
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
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: 'Password',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black))),
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
            const SizedBox(
              height: 30,
            ),
            RoundedButton(
              btnText: 'LOGIN',
              onBtnPressed: () => loginPressed(context),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const RegisterUserScreen(),
                    ));
              },
              child: Center(
                child: const Text(
                  'Register As User',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const RegisterPartnerScreen(),
                    ));
              },
              child: Center(
                child: const Text(
                  'Register As Partner',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
