// ignore_for_file: file_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Models/category.dart';

import '../Models/boxs.dart';
import '../Models/partner_category.dart';
import '../Services/globals.dart';
import '../Services/users.dart';
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
                    left: 20,
                    right: 20,
                    top: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
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
                        color: Colors.red,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 150),
                                child: Text(
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
                          const SizedBox(height: 40),
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
                                const SizedBox(width: 200),
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
                            CustomCategoryFilter(
                                categories: Category.categories),
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
                                const SizedBox(width: 180),
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
                            CustomPartnerCategoryFilter(
                              partnercategories:
                                  PartnerCategory.partnercategories,
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
