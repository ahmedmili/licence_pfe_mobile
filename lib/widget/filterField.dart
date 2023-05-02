// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Models/category.dart';

import '../Models/partner_category.dart';

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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                    _isFoodCategoriesExpanded = !_isFoodCategoriesExpanded;
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
                CustomCategoryFilter(categories: Category.categories),
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
                  partnercategories: PartnerCategory.partnercategories,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
