// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saverapp/Services/geoLocator.dart';

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
            geoController.getLocation();

            geoController.getAddressFromLatLng();

            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       title: Text(
            //         'SET POSITION',
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.green[800]),
            //       ),
            //       content: const LocationForm(),
            //       actions: <Widget>[
            //         TextButton(
            //           child: Text(
            //             'SAVE',
            //             style: TextStyle(
            //                 fontSize: 20,
            //                 color: Colors.green.shade800,
            //                 fontWeight: FontWeight.bold),
            //           ),
            //           onPressed: () {
            //             Get.back();
            //           },
            //         ),
            //       ],
            //     );
            //   },
            // );

            ///
            break;
          case "Map":
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return FractionallySizedBox(
                  widthFactor: 1.5, // Adjust the width as needed
                  heightFactor: 1, // Adjust the height as needed
                  child: AlertDialog(
                    title: Text(
                      'Select Position',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    content: GetBuilder<GeoLocatorController>(
                        builder: (controllerr) {
                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse(geoController.lat.value),
                            double.parse(
                              geoController.long.value,
                            ),
                          ),
                          zoom: 14,
                        ),
                        markers: {
                          Marker(
                            alpha: 0.5,
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueCyan),
                            markerId: const MarkerId('user_position'),
                            position: LatLng(
                              double.parse(geoController.lat.value),
                              double.parse(
                                geoController.long.value,
                              ),
                            ),
                            infoWindow:
                                const InfoWindow(title: 'your position'),
                          ),
                        },
                        onTap: (LatLng latLng) async {
                          geoController.lat.value = latLng.latitude.toString();
                          geoController.long.value =
                              latLng.longitude.toString();
                          geoController.getAddressFromLatLng();
                          // Get.back();
                        },
                      );
                    }),
                    actions: <Widget>[
                      GetBuilder<GeoLocatorController>(builder: (controllerr) {
                        return Text(controllerr.adress.value);
                      }),
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
                  ),
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
