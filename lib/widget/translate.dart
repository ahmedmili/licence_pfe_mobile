import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSwitchDropdown extends StatefulWidget {
  const LanguageSwitchDropdown({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LanguageSwitchDropdownState createState() => _LanguageSwitchDropdownState();
}

class _LanguageSwitchDropdownState extends State<LanguageSwitchDropdown> {
  // String _selectedLanguage = 'en';
  String _selectedLanguage =
      Get.deviceLocale.toString() == "fr_TN" ? "fr" : "en";

  final List<String> _languages = ['en', 'fr'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _selectedLanguage,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        onChanged: (String? newValue) {
          setState(() {
            _selectedLanguage = newValue!;
            Get.updateLocale(Locale(newValue, ''));
          });
        },
        items: _languages.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
