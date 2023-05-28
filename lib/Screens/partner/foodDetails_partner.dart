// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Screens/partner/editBox_partner.dart';
import 'package:saverapp/Services/globals.dart';
import '../../Models/boxs.dart';

class FoodDetailsPartner extends StatefulWidget {
  const FoodDetailsPartner({super.key, required this.box});
  final Box box;

  @override
  State<FoodDetailsPartner> createState() => _FoodDetailsPartnerState();
}

class _FoodDetailsPartnerState extends State<FoodDetailsPartner> {
  @override
  Widget build(BuildContext context) {
    final box = widget.box;
    return Scaffold(
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: double.maxFinite,
            height: 270,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "http://$localhost:8000/storage/boxs_imgs/${box.image}"),
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          top: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //retour en arriere
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 270 - 20,
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.cube_box,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${"Title".tr} : ${box.title}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.fastfood_outlined,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${"Category".tr} : ${box.category}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.add_shopping_cart),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${"Initial_quantity".tr} : ${box.quantity}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        '${"Remaining_quantity".tr} : ${box.remaining_quantity}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_alarm),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${"Available from".tr} : ${box.startdate}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        '${"To".tr} : ${box.startdate}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //expandable text widget
                Row(
                  children: [
                    const Icon(Icons.description_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          "Description : ${box.description}",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 270 - 20,
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${box.oldprice} Dt',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${box.newprice} Dt',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: Container(
        height: 100,
        padding:
            const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditBox()),
            );
          },
          color: Colors.green[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "Edit".tr,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
