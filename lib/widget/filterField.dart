// ignore_for_file: file_names

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
              const SizedBox(height: 20),
              const Text(
                "Food Categories :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              // CustomCategoryFilter(categories: Category.categories),
              const SizedBox(height: 20),
              const Text(
                "Partner Categories :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
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
