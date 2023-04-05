import 'package:flutter/material.dart';
import 'package:saverapp/Models/boxs.dart';

import 'neuButton.dart';

// ignore: must_be_immutable
class BoxCard extends StatefulWidget {
  BoxCard(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.newPrice,
      required this.oldPrice});

  String image;
  String title;
  String description;
  String newPrice;
  String oldPrice;

  @override
  State<BoxCard> createState() => _BoxCardState();
}

class _BoxCardState extends State<BoxCard> {
  bool isButtonPressed = false;

  void buttonPresssed() {
    setState(() {
      if (isButtonPressed == false) {
        isButtonPressed = true;
      } else if (isButtonPressed = true) {
        isButtonPressed = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(0, 0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
          BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 15.0,
              spreadRadius: 1.0),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 190.0,
              width: 340.0,
              child: Image.network(
                "http://10.0.2.2:8000/storage/boxs_imgs/${widget.image}",
                fit: BoxFit.cover,
                height: 150,
              ),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              child: Container(
                height: 60.0,
                width: 340.0,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.black12],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10.0,
              bottom: 10.0,
              right: 10.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: <Widget>[
                      Text(
                        '${widget.oldPrice} Dt',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        '${widget.newPrice} Dt',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
                left: 290.0,
                top: 5,
                child: NeuButton(
                  onTap: buttonPresssed,
                  isButtonPressed: isButtonPressed,
                )),
          ],
        ),
      ),
    );
  }
}
