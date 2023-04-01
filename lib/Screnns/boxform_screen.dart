import 'package:flutter/material.dart';

class BoxFormScreen extends StatefulWidget {
  const BoxFormScreen({super.key, required String title});

  @override
  State<BoxFormScreen> createState() => _BoxFormScreenState();
}

class _BoxFormScreenState extends State<BoxFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (const Text("Add New Box")),
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
          )
        ],
      ),
    );
  }
}
