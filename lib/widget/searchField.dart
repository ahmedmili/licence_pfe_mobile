// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20.0),
        child: TextField(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 14.0),
            hintText: "To Research",
            suffixIcon: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              child: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
