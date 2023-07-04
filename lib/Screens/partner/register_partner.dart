// ignore_for_file: depend_on_referenced_packages, avoid_init_to_null

import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saverapp/Screens/login.dart';
import 'package:saverapp/Screens/waiting.dart';
import 'package:saverapp/Services/geoLocator.dart';
import '../../Services/auth.dart';
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
          Get.snackbar(
              backgroundColor: Colors.red,
              "error".tr,
              err["phone"][0],
              colorText: Colors.white);
        } else if (err["email"] != null) {
          Get.snackbar(
              backgroundColor: Colors.red,
              "error".tr,
              err["email"][0],
              colorText: Colors.white);
        } else if (err["name"] != null) {
          Get.snackbar(
              backgroundColor: Colors.red,
              "error".tr,
              err["name"][0],
              colorText: Colors.white);
        } else if (err["password"] != null) {
          Get.snackbar(
              backgroundColor: Colors.red,
              "error".tr,
              err["password"][0],
              colorText: Colors.white);
        } else if (err["image"] != null) {
          Get.snackbar(
              backgroundColor: Colors.red,
              "error".tr,
              err["image"][0],
              colorText: Colors.white);
        } else if (err["category"] != null) {
          Get.snackbar(
              backgroundColor: Colors.red,
              "error".tr,
              err["category"][0],
              colorText: Colors.white);
        } else if (err["description"] != null) {
          Get.snackbar(
              backgroundColor: Colors.red,
              "error".tr,
              err["description"][0],
              colorText: Colors.white);
        } else if (err["openingtime"] != null) {
          Get.snackbar(
              backgroundColor: Colors.red,
              "error".tr,
              err["openingtime"][0],
              colorText: Colors.white);
        } else if (err["closingtime"] != null) {
          Get.snackbar(
              backgroundColor: Colors.red,
              "error".tr,
              err["closingtime"][0],
              colorText: Colors.white);
        }
      } else if (response["status"] == 201) {
        Get.snackbar(
            backgroundColor: Colors.white,
            "success".tr,
            response["message"],
            colorText: Colors.green.shade800);
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
                    color: Colors.white,
                    border: Border.all(color: Colors.green.shade800, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name'.tr,
                        hintStyle: TextStyle(color: Colors.grey.shade800),
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
                    color: Colors.white,
                    border: Border.all(color: Colors.green.shade800, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.grey[800]),
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
                    color: Colors.white,
                    border: Border.all(color: Colors.green.shade800, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey[800]),
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
                    color: Colors.white,
                    border: Border.all(color: Colors.green.shade800, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone'.tr,
                        hintStyle: TextStyle(color: Colors.grey[800]),
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
                    color: Colors.white,
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
                        hintStyle: TextStyle(color: Colors.grey[800]),
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
              SizedBox(
                width: 360,
                child: ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(360, 40),
                    // padding: EdgeInsets.symmetric(horizontal: 20),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.green.shade800, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select_Image'.tr,
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
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
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey[800]),
              ),

              // buttons
              SizedBox(
                width: 360,
                child: MaterialButton(
                  onPressed: _showTimePicker,
                  color: Colors.white,
                  height: 40,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.green.shade800, // Couleur de la bordure
                      width: 2.0, // Largeur de la bordure
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time_outlined, color: Colors.grey[800]),
                      const SizedBox(width: 5),
                      Text('Pick_Opening_Time'.tr,
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 15)),
                    ],
                  ),
                ),
              ),

              Text(
                _closingtime,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey[800]),
              ),

              SizedBox(
                width: 360,
                child: MaterialButton(
                  onPressed: _showClosingTimePicker,
                  color: Colors.white,
                  height: 40,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.green.shade800,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time_filled, color: Colors.grey[800]),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('Pick_Closing_Time'.tr,
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 15)),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.green.shade800,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 40,
                  width: 330,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: Text("Get_Position".tr,
                            style: TextStyle(
                                color: Colors.grey[800], fontSize: 15)),
                      ),
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
