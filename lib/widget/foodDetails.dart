import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'neonButton.dart';

class FoodDetails extends StatefulWidget {
  const FoodDetails({super.key});

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
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
    return Scaffold(
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: double.maxFinite,
            height: 270,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/two.png")),
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          top: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //retour en arriere
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
              //like
              NeuButton(
                onTap: buttonPresssed,
                isButtonPressed: isButtonPressed,
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 270 - 20,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("title"),
                SizedBox(
                  height: 20,
                ),
                Text("time"),
                SizedBox(
                  height: 20,
                ),
                //expandable text widget
                Expanded(
                  child: SingleChildScrollView(child: Text("description")),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 270 - 20,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("l'ancien prix"),
                SizedBox(
                  height: 20,
                ),
                Text("nouveau prix"),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green[800],
              ),
              child: MaterialButton(
                minWidth: 320,
                height: 60,
                onPressed: () {},
                child: Text(
                  "TO Book",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            // Icon(
            //   Icons.remove,
            //   color: Colors.green[800],
            // ),
            // SizedBox(
            //   width: 5,
            // ),
            // Text("0"),
            // SizedBox(
            //   width: 5,
            // ),
            // Icon(
            //   Icons.add,
            //   color: Colors.green[800],
            // ),
          ],
        ),
      ),
      // Container(
      //   padding:
      //       EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
      //   child: Text(
      //     "Add to cart",
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 20,
      //     ),
      //   ),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10),
      //     color: Colors.green[800],
      //   ),
      // )
    );
  }
}
