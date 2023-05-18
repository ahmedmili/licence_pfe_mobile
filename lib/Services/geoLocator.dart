// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saverapp/Services/users.dart';

class GeoLocatorController extends GetxController {
  //define data
  final lat = "".obs;
  final long = "".obs;
  RxString adress = "".obs;
  RxInt distance = 1.obs;
  static LatLng center = const LatLng(0, 0);

  //define google map markers indicators
  RxSet<Marker> markers = {
    Marker(
      // consumeTapEvents: true,
      alpha: 0.5,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      markerId: const MarkerId('user_position'),
      position: const LatLng(0, 0),
      infoWindow: const InfoWindow(title: 'your position'),
    ),
  }.obs;
//define cercle indicator
  RxSet<Circle> circles = {
    Circle(
      circleId: const CircleId('center'),
      center: const LatLng(0, 0),
      radius: 2000, // In meters
      fillColor: Colors.blue.withOpacity(0.1),
      strokeColor: Colors.blue.withOpacity(0.5),
      strokeWidth: 2,
    ),
  }.obs;

  //initialize cercle
  initCercle() {
    circles.clear();
    circles.add(
      Circle(
        circleId: const CircleId('center'),
        center: LatLng(double.parse(lat.value), double.parse(long.value)),
        radius: double.parse(distance.value.toString()) * 1000, // In meters
        fillColor: Colors.blue.withOpacity(0.1),
        strokeColor: Colors.blue.withOpacity(0.5),
        strokeWidth: 2,
      ),
    );
    update();
  }

  // initialize markers
  initMarkers() {
    markers.clear();
    markers.add(
      Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        markerId: const MarkerId('user_position'),
        position: LatLng(double.parse(lat.value), double.parse(long.value)),
        infoWindow: const InfoWindow(title: 'your position'),
      ),
    );
    update();
  }

// get partners by distance
  Future<void> getNearPartners(dist) async {
    await UserService.getNearByPartners(
      double.parse(long.value),
      double.parse(lat.value),
      dist,
      unity: "km",
    ).then((value) {
      if (value.isNotEmpty) {
        markers.value.clear();
        markers.add(
          Marker(
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
            markerId: const MarkerId('user_position'),
            position: LatLng(double.parse(lat.value), double.parse(long.value)),
            infoWindow: const InfoWindow(title: 'your position'),
          ),
        );
        for (int i = 0; i < value.length; i++) {
          var m = Marker(
            markerId: MarkerId(value[i]["name"]),
            position: LatLng(
              double.parse(value[i]['lat'].toString()),
              double.parse(value[i]['long'].toString()),
            ),
            infoWindow: InfoWindow(title: value[i]["name"]),
          );

          markers.add(m);
        }
      } else {
        markers.value.clear();
        markers.add(
          Marker(
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
            markerId: const MarkerId('user_position'),
            position: LatLng(double.parse(lat.value), double.parse(long.value)),
            infoWindow: const InfoWindow(title: 'your position'),
          ),
        );
      }
    });
    update();
  }

//
  // get user location from gps (lat,long)
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    update();
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getLocation() async {
    var location = await _determinePosition();
    lat.value = location.latitude.toString();
    long.value = location.longitude.toString();
    center = LatLng(location.latitude, location.longitude);
    update();
    return location.altitude.toString();
  }

  /// conver adress location (lat , longs) to Adress Name
  Future<String> getAddressFromLatLng() async {
    const apiKey = "AIzaSyBiZ8SjQd4I8sbCYk21luHXS3DITdhxSCo";

    final latlng = '${lat.value},${long.value}';
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latlng&key=$apiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded["status"] == "OK") {
        final String street = decoded["results"][0]["address_components"][1]
            ["short_name"]; // street name
        final String city = decoded["results"][0]["address_components"][3]
            ["short_name"]; //City name
        adress.value = "$street , $city";
        update();
        return adress.value.toString();
      } else {
        throw Exception("Failed to get address");
      }
    } else {
      throw Exception("Failed to get address: ${response.statusCode}");
    }
  }
}
