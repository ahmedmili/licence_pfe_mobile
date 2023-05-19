import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saverapp/Screens/partner/profile.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/partners.dart';
import '../../widget/Location_dropDawn.dart';
import '../../widget/google_map.dart';

class MePartner extends StatefulWidget {
  const MePartner({super.key});

  @override
  State<MePartner> createState() => _MePartnerState();
}

class _MePartnerState extends State<MePartner> {
  GeoLocatorController geoController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(height: 40),
          SizedBox(
            height: 20,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final card = profileCompletionCards[index];
                return SizedBox(
                  width: 190,
                  child: Card(
                    shadowColor: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Icon(
                            card.icon,
                            size: 30,
                            color: Colors.green[800],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            card.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Padding(padding: EdgeInsets.only(right: 5)),
              itemCount: profileCompletionCards.length,
            ),
          ),
          const SizedBox(
            child: Card(
              elevation: 4,
              shadowColor: Colors.black12,
              child: ListTile(
                leading: Icon(
                  Icons.location_on_outlined,
                ),
                title: Text("Location"),
                trailing: PopupLocationMenu(),
              ),
            ),
          ),
          const SizedBox(height: 5),
          ...List.generate(
            customListTiles.length,
            (index) {
              final tile = customListTiles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: InkWell(
                  onTap: () {
                    tile.cb();
                  },
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: ListTile(
                      leading: Icon(tile.icon),
                      title: Text(tile.title),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 5,
          ),
          // const Expanded(child: MapSample()),
          // Container(
          //   height: 200,
          //   width: 200,
          //   child: const MapSample(),
          // )
          // Expanded(
          // child:
          Container(
            width: 500,
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GoogleMap(
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
                      geoController.long.toString(),
                    ),
                  ),
                  infoWindow: const InfoWindow(title: 'your position'),
                ),
              },
            ),
          ),
          // ),
        ],
      ),
    );
  }
}

class ProfileCompletionCard {
  final String title;
  final IconData icon;
  ProfileCompletionCard({
    required this.title,
    required this.icon,
  });
}

List<ProfileCompletionCard> profileCompletionCards = [];

class CustomListTile {
  final dynamic cb;
  final IconData icon;
  final String title;
  CustomListTile({
    required this.cb,
    required this.icon,
    required this.title,
  });
  dynamic get age {
    return cb;
  }
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    cb: () {
      Get.to(() => const ProfilePartner());
    },
    icon: Icons.person_2_outlined,
    title: "Profile",
  ),
  CustomListTile(
    cb: () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var res = await PartnersService.logout();
      // if (res.statusCode == 200) {
      pref.setString("token", "");
      pref.setString("role", "");
      controller.setToken("");
      controller.setRole("");

      Get.offAllNamed("/");
      // }
    },
    title: "Logout",
    icon: CupertinoIcons.arrow_right_arrow_left,
  ),
];
