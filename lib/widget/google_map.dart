import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'package:saverapp/Services/users.dart';

import 'package:saverapp/widget/positionField.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GeoLocatorController geoController = Get.find<GeoLocatorController>();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static LatLng _center = const LatLng(0, 0);
  int? distance = 5;
  CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );

  Future<void> _getCurrentLocation() async {
    LatLng currentLocation = LatLng(double.parse(geoController.lat.value),
        double.parse(geoController.long.value));
    setState(() {
      _initialPosition = CameraPosition(
        target: currentLocation,
        zoom: 13,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    geoController.initMarkers();
    geoController.initCercle();
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    _center = LatLng(double.parse(geoController.lat.value),
        double.parse(geoController.long.value)); // current position

    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<GeoLocatorController>(
            builder: (controller) {
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _initialPosition,
                markers: controller.markers,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                // cameraTargetBounds: CameraTargetBounds(
                //   LatLngBounds(
                //     southwest: const LatLng(
                //         35.8011, 10.6092), // Southwest corner of Sousse
                //     northeast: const LatLng(
                //         35.8881, 10.6924), // Northeast corner of Sousse
                //   ),
                // ),
                circles: controller.circles,
              );
            },
          ),
          const Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: PositionField(),
          ),
        ],
      ),
    );
  }
}
