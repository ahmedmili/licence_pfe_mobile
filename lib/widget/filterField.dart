import 'package:flutter/material.dart';
import 'package:saverapp/Models/category.dart';

import 'custom_category_filter.dart';

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
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                "Food Categories :",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green[800]),
              ),
              CustomCategoryFilter(categories: Category.categories),
            ],
          ),
        ),
      ),
    );
  }
}
