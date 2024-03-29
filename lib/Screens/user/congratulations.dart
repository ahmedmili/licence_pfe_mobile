import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:saverapp/Models/partner.dart';

import 'package:saverapp/Screens/user/order.dart';

import '../../Models/order.dart';
import '../../Services/globals.dart';
import '../../widget/rounded_button.dart';
import 'package:http/http.dart' as http;

final GlobalController controller = Get.find<GlobalController>();

class Congratulations extends StatefulWidget {
  final Box box;
  final Partner partner;
  final int value;
  const Congratulations(
      {super.key,
      required this.box,
      required this.partner,
      required this.value});

  @override
  State<Congratulations> createState() => _CongratulationsState();
}

class _CongratulationsState extends State<Congratulations> {
  Order? newOrder;

  Future<void> placeOrder() async {
    final token = controller.token;
    String apiUrl = '${baseURL}user/orders/addorder';
    String body = '{"box_id": "${widget.box.id}", "quantity": ${widget.value}}';

    http.Response response = await http.post(Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data['user']);
      // print(data["boxs"][0]["pivot"]["command_id"]);
      // setState(() {
      newOrder = Order(
        command_id: data["boxs"][0]["pivot"]["command_id"],
        partner_name: data["boxs"][0]["partner"]["name"],
        partner_email: data["boxs"][0]["partner"]["email"],
        partner_phone: data["boxs"][0]["partner"]["phone"],
        user_name: data["user"]["name"],
        user_email: data["user"]["email"],
        user_phone: data["user"]["phone"],
        box_name: data['boxs'][0]["title"],
        box_category: data["boxs"][0]["category"],
        box_description: data["boxs"][0]["description"],
        box_startdate: data["boxs"][0]["startdate"],
        box_enddate: data["boxs"][0]["enddate"],
        quantity: data["boxs"][0]["pivot"]["quantity"],
        box_image: data["boxs"][0]["image"],
        oldprice: data["boxs"][0]["oldprice"],
        newprice: data["boxs"][0]["newprice"],
        price: data["price"],
        remainingQuantity: data["boxs"][0]['remaining_quantity'],
        created_at: data['created_at'],
      );

      Get.snackbar(
          backgroundColor: Colors.white,
          "sucess",
          "Your order has been successfully placed.",
          colorText: Colors.green.shade800);
    } else {
      // print("Something wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Text("Thank You", style: GoogleFonts.bebasNeue(fontSize: 52)),
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
                            'Reminder',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red[400]),
                          ),
                        ],
                      ),
                      content: const Text(
                        'Make sure to come at  the designated time. Your box will be waiting for you.',
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
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await placeOrder();
                            // print(newOrder!.box_category);
                            Get.to(
                              OrderScreen(
                                //box: widget.box,
                                //partner: widget.partner,
                                //value: widget.value,
                                neworder: newOrder,
                              ),
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
