import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'package:saverapp/Services/globals.dart';

class LocationForm extends StatefulWidget {
  const LocationForm({super.key});

  @override
  State<LocationForm> createState() => _LocationForm();
}

class _LocationForm extends State<LocationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GeoLocatorController geoControlle = Get.find();

  @override
  Widget build(BuildContext context) {
    // geoControlle.getLocation();
    // geoControlle.getAddressFromLatLng();
    // print(geoControlle.long.value);
    // print(geoControlle.lat.value);
    // print(geoControlle.adress.value);
    return SizedBox(
      height: 150,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(
              () {
                print("rebuild 1");
                _formKey.currentWidget;
                return TextFormField(
                  readOnly: true,
                  initialValue: "Longitude : ${geoControlle.long.value}",
                );
              },
            ),
            Obx(
              () {
                print("rebuild 2");
                return TextFormField(
                  initialValue: "Latitude : ${geoControlle.lat.value}",
                  readOnly: true,
                );
              },
            ),
            Obx(
              () {
                print("rebuild 3");
                return TextFormField(
                  initialValue: geoControlle.adress.value,
                  readOnly: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
