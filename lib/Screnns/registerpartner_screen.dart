import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Services/auth_service.dart';
import '../Services/globals.dart';
import '../rounded_button.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class RegisterPartnerScreen extends StatefulWidget {
  const RegisterPartnerScreen({Key? key}) : super(key: key);

  @override
  _RegisterPartnerScreenState createState() => _RegisterPartnerScreenState();
}

class _RegisterPartnerScreenState extends State<RegisterPartnerScreen> {
  String _name = '';
  String _description = '';
  String _email = '';
  String _phone = '';
  String _password = '';
  late File? _image = null;
  String _category = 'hi';
  // TimeOfDay _openingtime = TimeOfDay(hour: 8, minute: 30);
  String _openingtime = "";
  // TimeOfDay _closingtime = TimeOfDay(hour: 9, minute: 30);
  late String _closingtime = "hello";
  final int _roleId = 3;
  String _imageName = '';

  void _showTimePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    if (pickedTime != null) {
      DateTime dateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );
      setState(() {
        _openingtime = DateFormat('hh:mm:ss').format(dateTime);
      });
    }
  }

  void _showClosingTimePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    if (pickedTime != null) {
      DateTime dateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        pickedTime.hour,
        pickedTime.minute,
      );
      setState(() {
        _closingtime = DateFormat('hh:mm:ss').format(dateTime);
      });
    }
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

  void _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageName = path.basename(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: _image == null
            ? const Center(child: Text('Select Image'))
            : Image.file(_image!, fit: BoxFit.cover),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _category = categories.first;
  }

  Future<void> createAccountPressed() async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
    // print(_closingtime);
    if (emailValid) {
      http.Response response = await AuthServices.registerpartner(
          _name,
          _description,
          _email,
          _phone,
          _password,
          _image!,
          _category,
          _openingtime,
          _closingtime,
          _roleId);
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      // print(responseMap);
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(),
          ),
        );
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
      body: SingleChildScrollView(
        child: Padding(
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
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
              ),
              SizedBox(height: 8),
              Text(_imageName ?? 'No image selected'),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _image == null
                    ? Center(child: const Text('No image selected'))
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
              // Utilisez un DropdownButtonFormField pour sélectionner la catégorie
              Text(
                'Category',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
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
                _openingtime,
                style: TextStyle(fontSize: 5),
              ),

              // button
              MaterialButton(
                onPressed: _showTimePicker,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('PICK TIME',
                      style: TextStyle(color: Colors.white, fontSize: 2)),
                ),
                color: Colors.blue,
              ),

              Text(
                _closingtime,
                style: TextStyle(fontSize: 5),
              ),

              // button
              MaterialButton(
                onPressed: _showClosingTimePicker,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('PICK TIME',
                      style: TextStyle(color: Colors.white, fontSize: 2)),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
