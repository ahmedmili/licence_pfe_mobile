// ignore_for_file: library_private_types_in_public_api
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saverapp/Models/partner.dart';
import 'package:saverapp/Services/partners.dart';
import 'package:path/path.dart' as path;

import '../../Services/globals.dart';

class EditProfilePartner extends StatefulWidget {
  const EditProfilePartner({Key? key}) : super(key: key);

  @override
  _EditProfilePartnerState createState() => _EditProfilePartnerState();
}

class _EditProfilePartnerState extends State<EditProfilePartner> {
  // late Map<String, dynamic> user;
  late Partner partner;

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController categoryController;
  late TextEditingController openingtimeController;
  late TextEditingController closingtimeController;
  late TextEditingController newPasswordController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    descriptionController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    categoryController = TextEditingController();
    openingtimeController = TextEditingController();
    closingtimeController = TextEditingController();
    newPasswordController = TextEditingController();
    getUserInfo();
  }

  getUserInfo() async {
    late Partner partner;
    partner = await PartnersService.getPartnerInfo();
    setState(() {
      this.partner = partner;

      nameController.text = partner.name;
      descriptionController.text = partner.description;
      emailController.text = partner.email;
      phoneController.text = partner.phone.toString();
      categoryController.text = partner.category;
      openingtimeController.text = partner.openingtime.toString();
      closingtimeController.text = partner.closingtime.toString();
    });
  }

  updateUser() async {
    Map<String, dynamic> data = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': int.parse(phoneController.text),
      'category': categoryController.text.toUpperCase(),
      'openingtime': openingtimeController.text,
      'closingtime': closingtimeController.text,
      'description': descriptionController.text,
    };
    await PartnersService.updatePartner(data).then(
      (value) => setState(
        () {
          partner = value;
        },
      ),
    );
  }

  updatePassword() async {
    await PartnersService.updatePassword(nameController.text).then(
      (value) => setState(
        () {
          partner = value;
        },
      ),
    );
  }

// image update
  File? _image = null;
  String _imageName = '';

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

  // Future<void> updateImage () async {

  // http.Response response = await AuthServices.registerpartner(

  //       _image!,

  //     );
  //     Map<String, dynamic> responseMap = jsonDecode(response.body);

  //     if (response.statusCode == 200) {
  //       String token = responseMap['token'];

  //       Get.to(const Waiting());
  //     } else {
  //       Get.snackbar("error".tr, responseMap.values.first[0]);
  //     }

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            "Edit_Profile".tr,
            style: TextStyle(color: Colors.green.shade800),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'Name'.tr,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.description),
                      labelText: 'Description',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: const Icon(Icons.phone),
                      labelText: 'Phone'.tr,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: categoryController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: const Icon(Icons.store),
                      labelText: 'Category'.tr,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: openingtimeController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: const Icon(Icons.access_time),
                      labelText: 'Opening_Time'.tr,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: closingtimeController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: const Icon(Icons.access_time_filled),
                      labelText: 'Closing_Time'.tr,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 360,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      updateUser();
                    },
                    child: Text('Save'.tr),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // change image
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Change profile picture'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green[800]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 360,
                  child: ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey.shade600, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Select_Image'.tr,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: _image == null
                    ? const SizedBox()
                    : SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 360,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // print("save clicked 1");
                      PartnersService.updateImage(_image!);
                    },
                    child: Text('Save'.tr),
                  ),
                ),
              ),

              const SizedBox(height: 3),
              //change password
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Text(
                  "modifie_Password".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green[800]),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      prefixIcon: const Icon(Icons.lock),
                      labelText: 'New_password'.tr,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 360,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      updatePassword();
                    },
                    child: Text('Save'.tr),
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
