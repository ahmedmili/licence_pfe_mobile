import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saverapp/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/auth.dart';
import '../../widget/rounded_button.dart';
import '../login.dart';
import 'package:http/http.dart' as http;

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterUserScreen> {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _password = '';
  final int _roleId = 2;

  DateTime _selectedDate = DateTime.now();
  String? _selectedSex;

  createAccountPressed() async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);

    if (emailValid) {
      Map response = await AuthServices.register(
        _name,
        _email,
        _phone,
        _password,
        _roleId,
        _selectedSex.toString(),
        _selectedDate.toIso8601String(),
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
        } else if (err["sexe"] != null) {
          Get.snackbar(
              backgroundColor: Colors.red,
              "error".tr,
              err["sexe"][0],
              colorText: Colors.white);
        } else if (err["birthday"] != null) {
          Get.snackbar(
              backgroundColor: Colors.red,
              "error".tr,
              err["birthday"][0],
              colorText: Colors.white);
        }
      } else if (response["status"] == 200) {
        Get.snackbar(
            backgroundColor: Colors.white,
            "success".tr,
            response["message"],
            colorText: Colors.green.shade800);

        String token = response['token'];
        _save(token);
        Get.offNamed("/login");
        Get.snackbar(
            backgroundColor: Colors.white,
            "success",
            "Successfully registered.",
            colorText: Colors.green.shade800);
      }
    } else {
      Get.snackbar(
          backgroundColor: Colors.red,
          "Error",
          "Email not valid",
          colorText: Colors.white);
    }
    // } else {}
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            "Create Your Profile ",
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
              SizedBox(height: Dimensions.height30),
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
                        hintText: 'Name',
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
                height: 30,
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
                        hintStyle: TextStyle(color: Colors.grey.shade800),
                      ),
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
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
                        hintText: 'Phone',
                        hintStyle: TextStyle(color: Colors.grey.shade800),
                      ),
                      onChanged: (value) {
                        _phone = value;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
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
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey.shade800),
                      ),
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              /////
              ///
              ///
              ///

              // DropdownButtonFormField<String>(
              //   decoration: const InputDecoration(labelText: 'Gender'),
              //   items: ['male', 'female'] // male,female
              //       .map((String value) => DropdownMenuItem<String>(
              //             value: value,
              //             child: Text(value),
              //           ))
              //       .toList(),
              //   validator: (value) {
              //     if (value == null) {
              //       return 'Please select your gender';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedSex = value;
              //     });
              //   },
              //   value: _selectedSex, // Set the default value of the dropdown
              // ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Gender:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.green.shade800),
                    ),
                  ),
                  RadioListTile<String>(
                    title: const Text('Male'),
                    value: 'male',
                    groupValue: _selectedSex,
                    onChanged: (value) {
                      setState(() {
                        _selectedSex = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Female'),
                    value: 'female',
                    groupValue: _selectedSex,
                    onChanged: (value) {
                      setState(() {
                        _selectedSex = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /////
              ///
              ///*
              GestureDetector(
                onTap: () async {
                  final DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    // ignore: use_build_context_synchronously
                    // final TimeOfDay? time = await showTimePicker(
                    //   context: context,
                    //   initialTime: TimeOfDay.now(),
                    // );
                    // if (time != null) {
                    setState(() {
                      _selectedDate = DateTime(
                        date.year, date.month, date.day,
                        // time.hour, time.minute
                      );
                    });
                    // }
                  }
                },
                child: AbsorbPointer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.green.shade800, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                          controller: TextEditingController(
                            text: _selectedDate == null
                                ? ''
                                : DateFormat('yyyy-MM-dd')
                                    .format(_selectedDate),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'birth_date'.tr,
                            hintStyle: TextStyle(color: Colors.grey.shade800),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              ///
              ///
              RoundedButton(
                btnText: 'REGISTER',
                onBtnPressed: () => createAccountPressed(),
              ),
              const SizedBox(
                height: 15,
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
                  'Already have an account ? Login',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
