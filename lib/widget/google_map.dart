import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saverapp/Services/geoLocator.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GeoLocatorController geoController = Get.find<GeoLocatorController>();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );

  // final CameraPosition _lakePosition = const CameraPosition(
  //     bearing: 192.8334901395799,
  //     // target: LatLng(37.43296265331129, -122.08832357078792),
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LatLng currentLocation = LatLng(double.parse(geoController.lat.value),
        double.parse(geoController.long.value));
    setState(() {
      _initialPosition = CameraPosition(
        target: currentLocation,
        zoom: 14.4746,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_initialPosition.target);
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_lakePosition));
  // }
}
