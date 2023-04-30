import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Services/globals.dart';
import '../Models/boxs.dart';
import '../Models/category.dart';
import '../Services/users.dart';

class CustomCategoryFilter extends StatefulWidget {
  final List<Category> categories;

  const CustomCategoryFilter({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomCategoryFilterState createState() => _CustomCategoryFilterState();
}

class _CustomCategoryFilterState extends State<CustomCategoryFilter> {
  final GlobalController controller = Get.find<GlobalController>();

  List<Category> selectedCategories = [];

  Future<void> showBoxsForSelectedCategories() async {
    List<Box> boxs = [];
    for (Category category in selectedCategories) {
      await UserService.getAvailableBoxsByCategorys(category.name)
          .then((value) => boxs.addAll(value));
    }
    controller.setBoxsList(boxs);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.categories.length,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            top: 10,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.categories[index].name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
                child: Checkbox(
                  value: widget.categories[index].isSelected,
                  onChanged: (bool? newValue) {
                    setState(() {
                      widget.categories[index].isSelected = newValue ?? false;
                      selectedCategories = widget.categories
                          .where((category) => category.isSelected)
                          .toList();
                      showBoxsForSelectedCategories();
                    });
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
