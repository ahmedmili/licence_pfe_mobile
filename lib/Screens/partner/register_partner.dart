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
      Map response = await AuthServices.registerpartner(
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
      if (response["status"] == 400) {
        final err = response["error"];
        if (err["phone"] != null) {
          Get.snackbar("error".tr, err["phone"][0]);
        } else if (err["email"] != null) {
          Get.snackbar("error".tr, err["email"][0]);
        } else if (err["name"] != null) {
          Get.snackbar("error".tr, err["name"][0]);
        } else if (err["password"] != null) {
          Get.snackbar("error".tr, err["password"][0]);
        } else if (err["image"] != null) {
          Get.snackbar("error".tr, err["image"][0]);
        } else if (err["category"] != null) {
          Get.snackbar("error".tr, err["category"][0]);
        } else if (err["description"] != null) {
          Get.snackbar("error".tr, err["description"][0]);
        } else if (err["openingtime"] != null) {
          Get.snackbar("error".tr, err["openingtime"][0]);
        } else if (err["closingtime"] != null) {
          Get.snackbar("error".tr, err["closingtime"][0]);
        }
      } else if (response["status"] == 201) {
        Get.snackbar("success".tr, response["message"]);
        Get.to(const Waiting());
      }
    } else {
      Get.snackbar(
          backgroundColor: Colors.red,
          "Error".tr,
          "Enter all required fields.",
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            "${'register_slog'.tr} ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.green.shade800),
          ),
        ),
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name'.tr,
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone'.tr,
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password'.tr,
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
                child: Text('Select_Image'.tr),
              ),
              // Text(_imageName),
              const SizedBox(height: 3),
              SizedBox(
                child: _image == null
                    ? const SizedBox()
                    : Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade800),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Category'.tr,
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

              // buttons
              MaterialButton(
                onPressed: _showTimePicker,
                color: Colors.orange[900],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Pick_Opening_Time'.tr,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),

              Text(
                _closingtime,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.orange[900]),
              ),

              MaterialButton(
                onPressed: _showClosingTimePicker,
                color: Colors.orange[900],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Pick_Closing_Time'.tr,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15)),
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
                  width: 167,
                  child: Row(
                    children: [
                      Text("Get_Position".tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15)),
                      const Expanded(child: SizedBox()),
                      const PopupLocationMenu(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GetBuilder<GeoLocatorController>(builder: (controllerr) {
                return Text(controllerr.adress.value);
              }),

              RoundedButton(
                btnText: 'Send_Request'.tr,
                onBtnPressed: () => createAccountPressed(),
              ),

              const SizedBox(
                height: 10,
              ),

              GestureDetector(
                onTap: () {
                  Get.to(const LoginScreen());
                },
                child: Text(
                  'account_question'.tr,
                  style: const TextStyle(color: Colors.blue),
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
