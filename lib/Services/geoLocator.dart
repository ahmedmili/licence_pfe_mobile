// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GeoLocatorController extends GetxController {
  final lat = "".obs;
  final long = "".obs;
  final adress = "".obs;

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

    return await Geolocator.getCurrentPosition();
  }

  Future<String> getLocation() async {
    var location = await _determinePosition();
    lat.value = location.latitude.toString();
    long.value = location.longitude.toString();
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
        adress.value = decoded["results"][0]["formatted_address"];

        return decoded["results"][0]["formatted_address"];
      } else {
        throw Exception("Failed to get address");
      }
    } else {
      throw Exception("Failed to get address: ${response.statusCode}");
    }
  }
}
