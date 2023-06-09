// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saverapp/Services/globals.dart';
import 'package:saverapp/dimensions.dart';
import 'package:saverapp/widget/neonButtonPartner.dart';

class PartnerDetails extends StatefulWidget {
  const PartnerDetails({super.key});

  @override
  State<PartnerDetails> createState() => _PartnerDetailsState();
}

class _PartnerDetailsState extends State<PartnerDetails> {
  GlobalController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: Dimensions.width50),
              child: const Text(
                "Commerce Details",
                style: TextStyle(color: Colors.white),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close))
          ],
        ),
        backgroundColor: Colors.green[800],
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 0, right: 0),
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    height: 650,
                    width: Dimensions.width50 * 10,
                    padding:
                        const EdgeInsets.only(left: 35.0, right: 25.0, top: 0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: Dimensions.height20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: Dimensions.height30 * 2,
                                    width: Dimensions.width50 * 2,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                        "http://$localhost:8000/storage/partner_imgs/${controller.partner.image}",
                                        headers: {
                                          "Keep-Alive": "timeout=20",
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    controller.partner.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              //like
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 20),
                                child: NeuButtonPartner(),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height20 * 2),
                          Row(
                            children: [
                              SizedBox(width: Dimensions.width20),
                              Icon(
                                Icons.store,
                                color: Colors.green[800],
                              ),
                              SizedBox(width: Dimensions.width10 / 2),
                              Text(
                                "Category : ${controller.partner.category}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  //color: Colors.green[800]
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const SizedBox(width: 20),
                              Icon(
                                Icons.description_outlined,
                                color: Colors.green[800],
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    "Description : ${controller.partner.description}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height20),
                          Row(
                            children: [
                              const SizedBox(width: 20),
                              Icon(
                                Icons.phone_outlined,
                                color: Colors.green[800],
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Phone : ${controller.partner.phone}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height20),
                          Row(
                            children: [
                              SizedBox(width: Dimensions.width20),
                              Icon(
                                Icons.email_outlined,
                                color: Colors.green[800],
                              ),
                              SizedBox(width: Dimensions.width10 / 2),
                              Text(
                                "Email : ${controller.partner.email}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height20),
                          Row(
                            children: [
                              const SizedBox(width: 20),
                              Icon(
                                Icons.access_alarm_outlined,
                                color: Colors.green[800],
                              ),
                              SizedBox(width: Dimensions.width10 / 2),
                              Text(
                                "Opening Time : ${controller.partner.openingtime}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height20),
                          Row(
                            children: [
                              SizedBox(width: Dimensions.width20),
                              Icon(
                                Icons.access_time_filled,
                                color: Colors.green[800],
                              ),
                              SizedBox(width: Dimensions.width10 / 2),
                              Text(
                                "Closing Time : ${controller.partner.closingtime}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height10),
                          Row(
                            children: [
                              SizedBox(width: Dimensions.width20),
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.green[800],
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Address : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font16,
                                ),
                              ),
                              Text(
                                controller.partner.adress.toString(),
                                style: TextStyle(
                                  color: Colors.green.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white),
                              width: 500,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    double.parse(
                                        controller.partner.lat.toString()),
                                    double.parse(
                                      controller.partner.long.toString(),
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
                                      double.parse(
                                          controller.partner.lat.toString()),
                                      double.parse(
                                        controller.partner.long.toString(),
                                      ),
                                    ),
                                    infoWindow: const InfoWindow(
                                        title: 'your position'),
                                  ),
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
