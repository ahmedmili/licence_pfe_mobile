import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:saverapp/Services/globals.dart';
import 'package:saverapp/widget/filterField.dart';
import 'package:saverapp/widget/box_list_view.dart';

// import '../../Models/category.dart';
// import '../../widget/custom_category_filter.dart';
// import '../../widget/foodCategory.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final GlobalController controller = Get.find<GlobalController>();
  late List<Box> items;

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     items = controller.boxsList;
  //   });
  // }

  // bool listLength = controller.boxsList.isNotEmpty ? true : false;
  @override
  Widget build(BuildContext context) {
    print(controller.boxsList.length);
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const FilterField(),
                    ));
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
          child: BoxScreen(
            items: controller.boxsList,
            directions: "v",
          ),
        )
      ],
    );
  }
}
