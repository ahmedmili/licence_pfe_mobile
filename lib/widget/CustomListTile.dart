// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final dynamic cb;
  final IconData icon;
  final String title;

  const CustomListTile({
    super.key,
    required this.cb,
    required this.icon,
    required this.title,
  });

  dynamic get age {
    return cb;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: cb,
      leading: Icon(icon),
      title: Text(title),
    );
  }
}
