import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/box.dart';
import '../../Services/globals.dart';
import '../../dimensions.dart';
import '../../widget/rounded_button.dart';
import 'package:http/http.dart' as http;

class BoxFormScreen extends StatefulWidget {
  const BoxFormScreen({super.key});

  //const BoxFormScreen({required String title});

  @override
  State<BoxFormScreen> createState() => _BoxFormScreenState();
}

class _BoxFormScreenState extends State<BoxFormScreen> {
  String _title = '';
  String _description = '';
  String _oldprice = '';
  String _newprice = '';
  DateTime? _startDate;
  DateTime? _endDate;
  String _quantity = '';
  late File? _image = null;
  String _category = '';
  String _imageName = '';
  late String token;

  List<String> categories = [
    '',
    'FRUITS AND VEGETABLES',
    'MEAT',
    'PASTRY',
    'FISH',
    'DAIRY PRODUCTS',
    'PREPARED DISHES',
    'SWEETS',
    'DRINKS',
    'VEGETARIAN',
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
    readToken();
  }

  Future<void> createBoxPressed() async {
    http.Response response = await BoxServices.addBox(
      _title,
      _description,
      _oldprice,
      _newprice,
      _startDate!.toIso8601String(), // Convert DateTime to String
      _endDate!.toIso8601String(), // Convert DateTime to String
      _quantity,
      _image!,
      _category,
      token,
    );
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    print(responseMap["status"]);
    if (responseMap["status"] == 200) {
      Get.snackbar(
          backgroundColor: Colors.white,
          "sucess",
          "Box added successfully.",
          colorText: Colors.green.shade800);
      // Navigate to PartnerBoxes screen
      Get.toNamed("partnerMain");
    } else if (responseMap["status"] == 403) {
      Get.snackbar(
          backgroundColor: Colors.red,
          "error",
          "The start date must be before the end date.",
          colorText: Colors.white);
    } else if (responseMap["status"] == 422) {
      Get.snackbar(
          backgroundColor: Colors.red,
          "error",
          "Old price must be > New price.",
          colorText: Colors.white);
    } else if (responseMap["status"] == 400) {
      Get.snackbar(
          backgroundColor: Colors.red, "error", "Quantity should be ≥ 1");
    } else if (responseMap["status"] == 404) {
      Get.snackbar(
          backgroundColor: Colors.red,
          "error",
          "Max 2 days difference between start and end dates.",
          colorText: Colors.white);
    }
  }

  Future<void> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? "0";
    });
    createBoxPressed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: Dimensions.width20),
          child: Text(
            "${'add_box'.tr} :",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        backgroundColor: Colors.green[800],
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
              const SizedBox(height: 30),
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
                        hintText: 'Title'.tr,
                      ),
                      onChanged: (value) {
                        _title = value;
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Old_Price'.tr,
                      ),
                      onChanged: (value) {
                        _oldprice = value;
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
                        hintText: 'New_Price'.tr,
                      ),
                      onChanged: (value) {
                        _newprice = value;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  final DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        _startDate = DateTime(date.year, date.month, date.day,
                            time.hour, time.minute);
                      });
                    }
                  }
                },
                child: AbsorbPointer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border:
                            Border.all(color: Colors.green.shade800, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                          controller: TextEditingController(
                            text: _startDate == null
                                ? ''
                                : DateFormat('yyyy-MM-dd HH:mm')
                                    .format(_startDate!),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Start_Date'.tr,
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
              GestureDetector(
                onTap: () async {
                  final DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        _endDate = DateTime(date.year, date.month, date.day,
                            time.hour, time.minute);
                      });
                    }
                  }
                },
                child: AbsorbPointer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border:
                            Border.all(color: Colors.green.shade800, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextField(
                          controller: TextEditingController(
                            text: _endDate == null
                                ? ''
                                : DateFormat('yyyy-MM-dd HH:mm')
                                    .format(_endDate!),
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'End_Date'.tr,
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
                        hintText: 'Quantity'.tr,
                      ),
                      onChanged: (value) {
                        _quantity = value;
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
                    ? Center(
                        child: Text(
                        'No_image'.tr,
                        style: TextStyle(
                            color: Colors.orange[900],
                            fontWeight: FontWeight.bold),
                      ))
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
              const SizedBox(
                height: 15,
              ),
              // Utilisez un DropdownButtonFormField pour sélectionner la catégorie
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
                height: 25,
              ),

              RoundedButton(
                btnText: 'Create_Box'.tr,
                onBtnPressed: () => createBoxPressed(),
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
