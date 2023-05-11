// ignore_for_file: depend_on_referenced_packages, avoid_init_to_null

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saverapp/Screens/login.dart';
import 'package:saverapp/Screens/waiting.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/auth.dart';
import '../../Services/globals.dart';
import '../../widget/rounded_button.dart';
import 'package:http/http.dart' as http;
import '../../widget/Location_dropDawn.dart';

class RegisterPartnerScreen extends StatefulWidget {
  const RegisterPartnerScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
  String _openingtime = "";
  late String _closingtime = "";
  final int _roleId = 3;
  String _imageName = '';

  GeoLocatorController geoController = Get.find();
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
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageName = path.basename(pickedFile.path);
      } else {}
    });
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
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
        _roleId,
        double.parse(geoController.long.value),
        double.parse(geoController.lat.value),
        geoController.adress.value,
      );
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String token = responseMap['token'];
        _save(token);

        Get.to(const Waiting());
      } else {
        Get.snackbar("error", responseMap.values.first[0]);
      }
    } else {
      errorSnackBar(context, 'email not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
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
              Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Text(
                  "Create your profile to save your business : ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800]),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.green.shade800, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                      ),
                      onChanged: (value) {
                        _name = value;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.green.shade800, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Description',
                      ),
                      onChanged: (value) {
                        _description = value;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.green.shade800, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.green.shade800, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone',
                      ),
                      onChanged: (value) {
                        _phone = value;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.green.shade800, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[900],
                ),
                child: const Text('Select Image'),
              ),
              Text(_imageName),
              const SizedBox(height: 3),
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.shade800),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _image == null
                    ? const Center(child: Text('No image selected'))
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
              const SizedBox(
                height: 15,
              ),
              // Utilisez un DropdownButtonFormField pour sélectionner la catégorie
              Text(
                'Category',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.green[800]),
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
              const SizedBox(
                height: 15,
              ),
              Text(
                _openingtime,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue),
              ),

              // button
              MaterialButton(
                onPressed: _showTimePicker,
                color: Colors.orange[900],
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Pick Opening Time',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),

              Text(
                _closingtime,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.orange[900]),
              ),

              // button
              MaterialButton(
                onPressed: _showClosingTimePicker,
                color: Colors.orange[900],
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Pick Closing Time',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.orange[900],
                child: SizedBox(
                  height: 50,
                  width: 145,
                  child: Row(
                    children: const [
                      Text("Get Position",
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                      Expanded(child: SizedBox()),
                      PopupLocationMenu(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              Obx(() => Text(geoController.adress.value)),
              const SizedBox(
                height: 15,
              ),

              RoundedButton(
                btnText: 'Send Request',
                onBtnPressed: () => createAccountPressed(),
              ),

              const SizedBox(
                height: 10,
              ),

              GestureDetector(
                onTap: () {
                  Get.to(const LoginScreen());
                },
                child: const Text(
                  'Already have an account ? Login',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
