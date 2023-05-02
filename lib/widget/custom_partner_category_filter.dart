import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Services/globals.dart';
import '../Models/boxs.dart';
import '../Models/partner_category.dart';
import '../Services/users.dart';

class CustomPartnerCategoryFilter extends StatefulWidget {
  final List<PartnerCategory> partnercategories;

  const CustomPartnerCategoryFilter({
    Key? key,
    required this.partnercategories,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomPartnerCategoryFilterState createState() =>
      _CustomPartnerCategoryFilterState();
}

class _CustomPartnerCategoryFilterState
    extends State<CustomPartnerCategoryFilter> {
  final GlobalController controller = Get.find<GlobalController>();

  List<PartnerCategory> selectedPartnerCategories = [];

  Future<void> showBoxsForSelectedPartnerCategories() async {
    List<Box> boxs = [];
    for (PartnerCategory partnercategory in selectedPartnerCategories) {
      await UserService.getAvailableBoxsByPartnerCategorys(partnercategory.name)
          .then((value) => boxs.addAll(value));
    }
    controller.setBoxsList(boxs);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.partnercategories.length,
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
                widget.partnercategories[index].name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
                child: Checkbox(
                  value: widget.partnercategories[index].isSelected,
                  onChanged: (bool? newValue) {
                    setState(() {
                      widget.partnercategories[index].isSelected =
                          newValue ?? false;
                      selectedPartnerCategories = widget.partnercategories
                          .where(
                              (partnercategory) => partnercategory.isSelected)
                          .toList();
                      showBoxsForSelectedPartnerCategories();
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
