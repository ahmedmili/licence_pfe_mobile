import 'package:flutter/material.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:saverapp/Models/partner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/users.dart';

import 'neonButton.dart';

// ignore: must_be_immutable
class BoxCard extends StatefulWidget {
  BoxCard({
    super.key,
    required this.box,
  });

  Box box;

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

  Future<String> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "0";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readToken(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder<Partner>(
            future:
                UserService.getBoxPartnerInfo(snapshot.data!, widget.box.id),
            builder: (context, snapshot) {
              // print(snapshot.data!.name);
              if (snapshot.hasData) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(0, 0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                      const BoxShadow(
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
                            "http://10.0.2.2:8000/storage/boxs_imgs/${widget.box.image}",
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
                                    widget.box.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.box.description,
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
                                    '${widget.box.oldprice} Dt',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Text(
                                    '${widget.box.newprice} Dt',
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
                          ),
                        ),

                        //quantity
                        Container(
                          margin: const EdgeInsets.only(left: 5, top: 5),
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(6, 6),
                                  blurRadius: 15.0,
                                  spreadRadius: 1.0),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '${widget.box.remaining_quantity.toString()} to save',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.green[800]!),
                    strokeWidth: 5,
                  ),
                );
              }
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green[800]!),
              strokeWidth: 5,
            ),
          );
        }
      },
    );
  }
}
