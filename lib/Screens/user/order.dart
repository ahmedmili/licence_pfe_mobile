import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 70),
              child: Text(
                "Your Order",
                style: TextStyle(color: Colors.black),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close))
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 70,
            width: 450,
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.green[800],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                              fontSize: 16),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Less than 6 Km",
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
