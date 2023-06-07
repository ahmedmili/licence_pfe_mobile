import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saverapp/Screens/partner/profile.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/partners.dart';
import '../../dimensions.dart';
import '../../widget/CustomListTile.dart';
import '../../widget/Location_dropDawn.dart';
import '../../widget/translate.dart';
// import '../../widget/chart.dart';
// import '../../widget/google_map.dart';

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
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: Dimensions.width20),
          child: Text(
            "${"SETTINGS".tr}:",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Colors.green[800],
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: ListView(children: [
        Column(
          children: [
            const SizedBox(height: 70),
            SizedBox(
              child: Card(
                elevation: 4,
                shadowColor: Colors.black12,
                child: CustomListTile(
                  cb: () {
                    Get.toNamed("profilePartner");
                  },
                  icon: Icons.person_2_outlined,
                  title: "profile".tr,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: Card(
                elevation: 4,
                shadowColor: Colors.black12,
                child: CustomListTile(
                  cb: () {
                    Get.toNamed("partnerStats");
                  },
                  icon: CupertinoIcons.chart_bar,
                  title: "statistics".tr,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: Card(
                elevation: 4,
                shadowColor: Colors.black12,
                child: ListTile(
                  leading: const Icon(
                    Icons.location_on_outlined,
                  ),
                  title: Text("location".tr),
                  trailing: const PopupLocationMenu(),
                ),
              ),
            ),
            const SizedBox(height: 10),
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
                    infoWindow: InfoWindow(title: 'position'.tr),
                  ),
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              child: Card(
                elevation: 4,
                shadowColor: Colors.black12,
                child: CustomListTile(
                  cb: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    var res = await PartnersService.logout();
                    // if (res.statusCode == 200) {
                    pref.setString("token", "");
                    pref.setString("role", "");
                    controller.setToken("");
                    controller.setRole("");

                    Get.offAllNamed("/");
                    // }
                  },
                  icon: CupertinoIcons.arrow_right_arrow_left,
                  title: "logout".tr,
                ),
              ),
            ),
            const LanguageSwitchDropdown()
          ],
        ),
      ]),
    );
  }
}
