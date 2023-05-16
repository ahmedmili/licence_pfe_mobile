import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'package:saverapp/dimensions.dart';
import 'package:saverapp/widget/position.dart';
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

  CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 14.4746,
  );

  final CameraPosition _lakePosition = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LatLng currentLocation = LatLng(double.parse(geoController.lat.value),
        double.parse(geoController.long.value));
    setState(() {
      _center = LatLng(double.parse(geoController.lat.value),
          double.parse(geoController.long.value)); // current position
      _initialPosition = CameraPosition(
        target: currentLocation,
        zoom: 14.4746,
      );
    });
  }

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('great_mosque'),
      position: LatLng(35.8288, 10.6396),
      infoWindow: InfoWindow(title: 'Great Mosque of Sousse'),
    ),
    Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      markerId: const MarkerId('user_position'),
      position: _center,
      infoWindow: const InfoWindow(title: 'your poseition'),
    ),
  };

  final Set<Circle> _circles = {
    Circle(
      circleId: const CircleId('center'),
      center: _center,
      radius: 2000, // In meters
      fillColor: Colors.blue.withOpacity(0.1),
      strokeColor: Colors.blue.withOpacity(0.5),
      strokeWidth: 2,
    ),
  };
  @override
  Widget build(BuildContext context) {
    RangeValues _currentRangeValues = const RangeValues(0, 100);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            cameraTargetBounds: CameraTargetBounds(
              LatLngBounds(
                southwest: const LatLng(
                    35.8011, 10.6092), // Southwest corner of Sousse
                northeast: const LatLng(
                    35.8881, 10.6924), // Northeast corner of Sousse
              ),
            ),
            circles: _circles,
          ),
          Positioned(top: 10, left: 15, right: 15, child: PositionField()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_lakePosition));
  }
}
