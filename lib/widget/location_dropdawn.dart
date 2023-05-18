// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'location_inpute_form.dart';

class PopupLocationMenu extends StatefulWidget {
  const PopupLocationMenu({Key? key}) : super(key: key);

  @override
  State<PopupLocationMenu> createState() => _PopupLocationMenu();
}

class _PopupLocationMenu extends State<PopupLocationMenu> {
  GeoLocatorController geoController = Get.find();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'Add',
            child: Row(
              children: const [
                Icon(Icons.add_circle_outline),
                SizedBox(width: 8),
                Text('Get GPS Location '),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'Map',
            child: Row(
              children: const [
                Icon(Icons.settings),
                SizedBox(width: 8),
                Text('Get from map'),
              ],
            ),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert),
      onSelected: (String value) {
        switch (value) {
          case 'Add':
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'ADD POSITION',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800]),
                  ),
                  content: const LocationForm(),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                );
              },
            );
            break;
          case "Map":
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Select Position',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  content: GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(37.42796133580664, -122.085749655962),
                      zoom: 14,
                    ),
                    onTap: (LatLng latLng) async {},
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                );
              },
            );
            break;
          default:
        }
      },
    );
  }
}
