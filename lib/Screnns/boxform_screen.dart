import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/box_service.dart';
import '../Services/globals.dart';
import '../rounded_button.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BoxFormScreen extends StatefulWidget {
  const BoxFormScreen({super.key, required String title});

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
  String _status = '';
  String _imageName = '';

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

  List<String> status = [
    '',
    'PENDING',
    'ACCEPTED',
    'REJECTED',
    'FINISHED',
    'EXPIRED'
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

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "token";
    final value = token;
    prefs.setString(key, value);
  }

  @override
  void initState() {
    super.initState();
    _category = categories.first;
  }

  Future<void> createBoxPressed() async {
    http.Response response = await BoxServices.addBox(
      _title,
      _description,
      _oldprice as String,
      _newprice as String,
      _startDate!.toIso8601String(), // Convert DateTime to String
      _endDate!.toIso8601String(), // Convert DateTime to String
      _quantity as String,
      _image!,
      _category,
      _status,
    );
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (const Text("Add New Box")),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black)),
                ),
                onChanged: (value) {
                  _title = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black)),
                ),
                onChanged: (value) {
                  _description = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Old Price',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black)),
                ),
                onChanged: (value) {
                  _oldprice = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'New Price',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black)),
                ),
                onChanged: (value) {
                  _newprice = value;
                },
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
                  child: TextField(
                    controller: TextEditingController(
                      text: _startDate == null
                          ? ''
                          : DateFormat('yyyy-MM-dd HH:mm').format(_startDate!),
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
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
                  child: TextField(
                    controller: TextEditingController(
                      text: _endDate == null
                          ? ''
                          : DateFormat('yyyy-MM-dd HH:mm').format(_endDate!),
                    ),
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black)),
                ),
                onChanged: (value) {
                  _quantity = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
              ),
              Text(_imageName ?? 'No image selected'),
              SizedBox(height: 3),
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
              const SizedBox(
                height: 15,
              ),
              // Utilisez un DropdownButtonFormField pour sélectionner la catégorie
              Text(
                'Category',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue),
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
                'Status',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue),
              ),
              DropdownButtonFormField(
                value: _status,
                items: status.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value as String;
                  });
                },
              ),

              const SizedBox(
                height: 15,
              ),

              RoundedButton(
                btnText: 'Create Box',
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
