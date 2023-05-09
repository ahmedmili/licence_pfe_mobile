import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saverapp/Models/boxs.dart';

import 'package:saverapp/Screens/user/order.dart';

import '../../widget/rounded_button.dart';

class Congratulations extends StatefulWidget {
  final Box box;
  const Congratulations({super.key, required this.box});

  @override
  State<Congratulations> createState() => _CongratulationsState();
}

class _CongratulationsState extends State<Congratulations> {
  @override
  Widget build(BuildContext context) {
    print(widget.box.category);
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 40),
          child: Text(
            "Confirm Reservation",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.green[800],
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Thanks To You", style: GoogleFonts.bebasNeue(fontSize: 52)),
            const SizedBox(height: 10),
            Text(
              "This box won't go to waste",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green[800]),
            ),
            const SizedBox(height: 40),
            RoundedButton(
              btnText: 'CONFIRM',
              onBtnPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Icon(Icons.warning_amber_outlined,
                              color: Colors.red[400]),
                          const SizedBox(width: 5),
                          Text(
                            'That\'s good to remember',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red[400]),
                          ),
                        ],
                      ),
                      content: const Text(
                        'Please arrive at the designated time on your receipt - neither early nor late. Your box will be ready and waiting for you.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            'OK',
                            style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrderScreen(box: widget.box)),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
