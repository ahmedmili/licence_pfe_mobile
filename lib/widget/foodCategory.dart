import 'package:flutter/material.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:saverapp/Services/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

import '../Models/category.dart';
import '../data/categoryData.dart';
import 'box_list_view.dart';
import 'foodCard.dart';

class FoodCategory extends StatefulWidget {
  const FoodCategory({super.key});

  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  final List<Category> _categories = categories;
  late List<Box> boxs = [];

  Future<String> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "0";
  }

  // Future<List<Box>>
  showBoxs(token, category) async {
    List<Box> boxs = [];
    await UserService.getAvailableBoxsByCategorys(token, category)
        .then((value) => boxs.addAll(value));
    // print(boxs[1].id);
    setState(() {
      this.boxs = boxs;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: readToken(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 80.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: FoodCard(
                          categoryName: _categories[index].categoryName,
                          imagePath: _categories[index].imagePath,
                        ),
                        onTap: () async => showBoxs(
                          snapshot.data,
                          _categories[index].categoryName,
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            }),
        const SizedBox(
          height: 40,
        ),
        boxs.isNotEmpty
            ? Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: BoxScreen(
                    items: boxs,
                    directions: "V",
                  ),
                ),
              )
            : const Text("no boxs here"),
      ],
    );
  }
}
