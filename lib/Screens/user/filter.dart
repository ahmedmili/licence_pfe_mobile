import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:saverapp/Services/globals.dart';
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
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (BuildContext context) => const FilterField(),
                //     ));
                Get.to(const FilterField());
              },
              child: SizedBox(
                height: 50,
                width: 50,
                child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Icon(
                      Icons.menu,
                      color: Colors.green[800],
                    )),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 330,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20.0),
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
        //////////

        Expanded(
          child: GetBuilder<GlobalController>(
            init: GlobalController(),
            builder: (c) {
              print(c.boxsList.length);

              if (c.boxsList.isEmpty) {
                return const Text("no data found");
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
