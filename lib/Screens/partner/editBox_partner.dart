// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import '../../dimensions.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:saverapp/Services/globals.dart';
import 'package:saverapp/Services/box.dart';

import '../../widget/rounded_button.dart';

class EditBox extends StatefulWidget {
  const EditBox({super.key});

  @override
  State<EditBox> createState() => _EditBoxState();
}

class _EditBoxState extends State<EditBox> {
  final GlobalController controller = Get.find<GlobalController>();

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

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController enddateController;
  late TextEditingController categoryController;
  late TextEditingController oldpriceController;
  late TextEditingController newpriceController;
  late TextEditingController startdatetimeController;
  late TextEditingController quantityController;
  late TextEditingController remainingQuantityController;
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

    titleController = TextEditingController();
    descriptionController = TextEditingController();
    categoryController = TextEditingController();

    enddateController = TextEditingController();
    oldpriceController = TextEditingController();
    newpriceController = TextEditingController();
    startdatetimeController = TextEditingController();
    quantityController = TextEditingController();
    remainingQuantityController = TextEditingController();

    final Box box = controller.box;
    titleController.text = box.title;
    descriptionController.text = box.description;
    enddateController.text = box.enddate;
    oldpriceController.text = box.oldprice;
    newpriceController.text = box.newprice;
    categoryController.text = box.category;
    startdatetimeController.text = box.startdate;
    quantityController.text = box.quantity.toString();
    remainingQuantityController.text = box.remainingQuantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    final Box box = controller.box;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: Dimensions.width20),
          child: const Text(
            "${'Edit Box'} :",
            style: TextStyle(
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
                    color: Colors.white,
                    border: Border.all(color: Colors.green.shade800, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title'.tr,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _title = value;
                        });
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
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Description',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _description = value;
                        });
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
                      controller: oldpriceController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Old_Price'.tr,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _oldprice = value;
                        });
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
                      controller: newpriceController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'New_Price'.tr,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _newprice = value;
                        });
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
                    // ignore: use_build_context_synchronously
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        _startDate = DateTime(date.year, date.month, date.day,
                            time.hour, time.minute);
                        startdatetimeController.text = _startDate.toString();
                      });
                    }
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
                            text: _startDate == null
                                ? startdatetimeController.text
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
                    // ignore: use_build_context_synchronously
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        _endDate = DateTime(date.year, date.month, date.day,
                            time.hour, time.minute);
                        enddateController.text = _endDate.toString();
                      });
                    }
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
                            text: _endDate == null
                                ? enddateController.text
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
                    color: Colors.white,
                    border: Border.all(color: Colors.green.shade800, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      controller: quantityController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Quantity'.tr,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _quantity = value;
                        });
                      },
                    ),
                  ),
                ),
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
                value: categoryController.text,
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value as String;
                    categoryController.text = _category;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              RoundedButton(
                btnText: "${'Save'.tr}",
                onBtnPressed: () {
                  BoxServices.updateBoxDetails(
                    box.id,
                    titleController.value.text,
                    descriptionController.value.text,
                    oldpriceController.value.text,
                    newpriceController.value.text,
                    startdatetimeController.value.text,
                    enddateController.value.text,
                    quantityController.value.text,
                    categoryController.value.text,
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              // image section
              Container(
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
                  child: Text(
                    'Select_Image'.tr,
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ),
              ),
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
                height: 25,
              ),

              /// save image button
              _image != null
                  ? RoundedButton(
                      btnText: "${'Save'.tr} IMAGE",
                      onBtnPressed: () {
                        BoxServices.updateBoxImage(_image!, box.id);
                      })
                  : const SizedBox(),
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
