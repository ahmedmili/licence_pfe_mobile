import 'package:flutter/material.dart';

// This is the type used by the popup menu below.
enum SampleItem { itemOne, itemTwo, itemThree }

class PopupLocationMenu extends StatefulWidget {
  const PopupLocationMenu({super.key});

  @override
  State<PopupLocationMenu> createState() => _PopupLocationMenu();
}

class _PopupLocationMenu extends State<PopupLocationMenu> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'Add',
            child: Row(
              children: const [
                Icon(Icons.add_circle_outline),
                SizedBox(width: 8),
                Text('Add'),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'see',
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  print(' test dialog');
                  return Text("data");
                },
              );
            },
            child: Row(
              children: const [
                Icon(Icons.settings),
                SizedBox(width: 8),
                Text('see All'),
              ],
            ),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert),
      onSelected: (String value) {
        // Do something when a menu item is selected
      },
    );
  }
}
