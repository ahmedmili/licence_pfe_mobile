import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Services/geoLocator.dart';

class LocationForm extends StatefulWidget {
  const LocationForm({super.key});

  @override
  State<LocationForm> createState() => _LocationForm();
}

class _LocationForm extends State<LocationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GeoLocatorController geoControlle = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // () async {
    geoControlle.getLocation();
    geoControlle.getAddressFromLatLng();
    //   Future.delayed(const Duration(minutes: 1));
    // };
    return SizedBox(
      height: 150,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(
              () => TextFormField(
                readOnly: true,
                initialValue: geoControlle.long.value,
              ),
            ),
            Obx(
              () => TextFormField(
                initialValue: geoControlle.lat.value,
                readOnly: true,
              ),
            ),
            Obx(
              () => TextFormField(
                initialValue: geoControlle.adress.value,
                readOnly: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
