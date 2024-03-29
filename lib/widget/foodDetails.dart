// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Models/partner.dart';
import 'package:saverapp/Services/globals.dart';
import '../Models/boxs.dart';
import '../Screens/user/congratulations.dart';
import '../dimensions.dart';
import 'neonButton.dart';

class FoodDetails extends StatefulWidget {
  const FoodDetails({super.key, required this.box, required this.partner});
  final Box box;
  final Partner partner;

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  int value = 1;
  void increment() {
    if (value < widget.box.remainingQuantity) {
      setState(() {
        value++;
      });
    }
  }

  void decrement() {
    if (value > 1) {
      setState(() {
        value--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = widget.box;
    final partner = widget.partner;
    bool isliked = widget.box.likes == 1 ? true : false;

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
              //like
              NeuButton(
                boxid: box.id,
                isLiked: isliked,
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          top: 170,
          child: GestureDetector(
            onTap: () {
              Get.toNamed('/partnerdetails', arguments: partner);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      "http://$localhost:8000/storage/partner_imgs/${partner.image}",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  partner.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
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
                      box.title,
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
                      Icons.production_quantity_limits,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Remaining Quantity : ${box.remainingQuantity}",
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
                        const Icon(Icons.access_alarm),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Available from : ${box.startdate}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        'To : ${box.startdate}',
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
                          "Description of this box : ${box.description}",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/partnerdetails', arguments: partner);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              // children: [
                              //   SizedBox(height: 20),
                              //   Icon(Icons.location_on_outlined),
                              //   Text(widget.partner.adress.toString(),
                              //       style: TextStyle(
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.green.shade800,
                              //       )),
                              // ],
                              ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  "More information about ${partner.name}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                )
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Valeur actuelle'),
                      content: Text(value.toString()),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              minWidth: 100,
              color: Colors.green[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.white),
                    onPressed: decrement,
                  ),
                  Text(
                    value.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: increment,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Congratulations(
                            box: box,
                            partner: partner,
                            value: value,
                          )),
                );
              },
              color: Colors.green[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minWidth: 200,
              child: const Text(
                "TO RESERVE",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
