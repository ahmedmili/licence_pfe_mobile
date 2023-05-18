import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:saverapp/Services/globals.dart';
import 'package:saverapp/dimensions.dart';
import 'package:saverapp/widget/filterField.dart';
import 'package:saverapp/widget/box_list_view.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final GlobalController controller = Get.find<GlobalController>();
  late List<Box> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Get.to(const FilterField());
              },
              child: SizedBox(
                height: Dimensions.height50,
                width: Dimensions.width50,
                child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Icon(
                      Icons.menu,
                      color: Colors.green[800],
                    )),
              ),
            ),
            SizedBox(width: Dimensions.width10),
            SizedBox(
              width: 330,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 14.0),
                    hintText: "To Research",
                    suffixIcon: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.green[800],
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: GetBuilder<GlobalController>(
            init: GlobalController(),
            builder: (c) {
              if (c.boxsList.isEmpty) {
                return Column(
                  children: [
                    const SizedBox(height: 120),
                    Container(
                        height: 200,
                        width: 200,
                        child: Image(
                            image: AssetImage("assets/images/chercher.png"))),
                    const SizedBox(height: 5),
                    Text(
                      "Filter boxes as needed.",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange.shade900,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                );
              } else {
                return Container(
                  margin: const EdgeInsets.only(left: 8),
                  width: 340,
                  child: BoxScreen(
                    items: c.boxsList,
                    directions: "v",
                  ),
                );
              }
            },
            // child:
          ),
        ),
      ],
    );
  }
}
