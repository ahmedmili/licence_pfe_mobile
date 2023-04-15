import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:saverapp/widget/filterField.dart';

import '../../Models/category.dart';
import '../../widget/custom_category_filter.dart';
import '../../widget/foodCategory.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const FilterField(),
                    ));
              },
              child: Container(
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
            Container(
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
      ],
    );
  }
}
