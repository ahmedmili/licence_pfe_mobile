// ignore_for_file: file_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Models/category.dart';
import 'package:saverapp/dimensions.dart';

import '../Models/partner_category.dart';

import 'MoneyFilterWidget.dart';
import 'custom_category_filter.dart';
import 'custom_partner_category_filter.dart';

class FilterField extends StatefulWidget {
  const FilterField({super.key});

  @override
  State<FilterField> createState() => _FilterFieldState();
}

class _FilterFieldState extends State<FilterField> {
  bool _isFoodCategoriesExpanded = false;
  bool _isPartnerCategoriesExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 250,
            child: Image.asset(
              "assets/images/food.png",
              height: 2,
              width: 10,
              // fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: Stack(
                children: [
                  Positioned(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.pop(context);
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 120 - 20,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Dimensions.height15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Dimensions.width50 * 3),
                                child: const Text(
                                  "Filters",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Icon(Icons.close)),
                            ],
                          ),
                          Text(
                            "Price :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.green[800],
                            ),
                          ),
                          SizedBox(height: Dimensions.height10),
                          SizedBox(
                            height: 48,
                            width: Dimensions.width50 * 8,
                            child: const MoneyFilter(),
                          ),
                          SizedBox(height: Dimensions.height20 * 2),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isFoodCategoriesExpanded =
                                    !_isFoodCategoriesExpanded;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Food Categories :",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.green[800],
                                  ),
                                ),
                                SizedBox(width: Dimensions.width45 * 4),
                                Icon(
                                  _isFoodCategoriesExpanded
                                      ? Icons.arrow_drop_down
                                      : Icons.arrow_drop_up,
                                  color: Colors.green[800],
                                ),
                              ],
                            ),
                          ),
                          if (_isFoodCategoriesExpanded)
                            Expanded(
                              child: CustomCategoryFilter(
                                  categories: Category.categories),
                            ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isPartnerCategoriesExpanded =
                                    !_isPartnerCategoriesExpanded;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Partner Categories :",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.green[800],
                                  ),
                                ),
                                SizedBox(width: Dimensions.width40 * 4),
                                Icon(
                                  _isPartnerCategoriesExpanded
                                      ? Icons.arrow_drop_down
                                      : Icons.arrow_drop_up,
                                  color: Colors.green[800],
                                ),
                              ],
                            ),
                          ),
                          if (_isPartnerCategoriesExpanded)
                            Expanded(
                              child: CustomPartnerCategoryFilter(
                                partnercategories:
                                    PartnerCategory.partnercategories,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
