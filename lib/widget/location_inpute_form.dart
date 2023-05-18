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
  Widget build(BuildContext context) {
    geoControlle.getLocation();
    geoControlle.getAddressFromLatLng();

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
                initialValue: "Longitude : ${geoControlle.long.value}",
              ),
            ),
            Obx(
              () => TextFormField(
                initialValue: "Latitude : ${geoControlle.lat.value}",
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
