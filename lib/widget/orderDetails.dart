import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saverapp/Models/order.dart';
import 'package:saverapp/dimensions.dart';
import 'package:saverapp/widget/rounded_button.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.order});
  final Order order;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  //var qrstr = 'Add Data';
  @override
  Widget build(BuildContext context) {
    var data = {widget.order.command_id, widget.order.partner_id};
    // final qrstr = "${widget.order.command_id}";
    final qrstr = "$data";
    final order = widget.order;
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 55),
          child: Text(
            "Order Details ",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        backgroundColor: Colors.green[800],
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 570,
            width: 450,
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.cube_box,
                              color: Colors.green[800],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              order.box_name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height10),
                    Row(
                      children: [
                        Icon(
                          Icons.store,
                          color: Colors.green[800],
                        ),
                        SizedBox(width: Dimensions.width10 / 2),
                        Text(
                          order.box_category,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.description_outlined,
                          color: Colors.green[800],
                        ),
                        const SizedBox(width: 5),
                        Text(
                          order.box_description,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height10),
                    Row(
                      children: [
                        Icon(
                          Icons.access_alarm,
                          color: Colors.green[800],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${order.box_startdate} -> ${order.box_enddate}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height10),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Box Price :",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.font28 / 2,
                              ),
                            ),
                            Text(
                              "${order.newprice} Dt",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font16,
                                  color: Colors.green[800]),
                            ),
                          ],
                        ),
                        SizedBox(width: Dimensions.width20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Quantity :",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.font28 / 2,
                              ),
                            ),
                            Text(
                              "${order.quantity} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font28 / 2,
                                  color: Colors.green[800]),
                            ),
                          ],
                        ),
                        SizedBox(width: Dimensions.width20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Total :",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.font28 / 2,
                              ),
                            ),
                            Text(
                              "${order.price} Dt",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.green[800]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height10),
                    const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(height: Dimensions.height10 / 2),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(height: Dimensions.height20),
                                Icon(
                                  Icons.person,
                                  color: Colors.green[800],
                                ),
                                SizedBox(width: Dimensions.width10 / 2),
                                Text(
                                  order.user_name,
                                  style: TextStyle(
                                      fontSize: Dimensions.font16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              children: [
                                SizedBox(height: Dimensions.height20),
                                Icon(
                                  Icons.email,
                                  color: Colors.green[800],
                                ),
                                SizedBox(width: Dimensions.width10 / 2),
                                Text(
                                  order.user_email,
                                  style: TextStyle(
                                      fontSize: Dimensions.font16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const SizedBox(height: 20),
                                Icon(
                                  Icons.phone,
                                  color: Colors.green[800],
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "${order.user_phone}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.qr_code,
                              color: Colors.green[800],
                            ),
                            SizedBox(width: Dimensions.height10 / 5),
                            Text(
                              'It is necessary that the owner of order scan this code.',
                              style: TextStyle(
                                  fontSize: Dimensions.font24 / 2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 70, top: 30, right: 70),
                          child: RoundedButton(
                            btnText: 'SHOW QRCODE',
                            onBtnPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.all(
                                        0), // Supprime les paddings par défaut
                                    content: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Container(
                                          width: 100,
                                          height: 250,
                                          child: BarcodeWidget(
                                            data: qrstr,
                                            barcode: Barcode.qrCode(),
                                            color: Colors.black,
                                            width: Dimensions.width50 * 6,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(height: Dimensions.height25),
                        Padding(
                          padding:
                              EdgeInsets.only(left: Dimensions.width50 * 2),
                          child: Text(
                            " Order Created at : ${order.created_at}",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800]),
                          ),
                        ),
                      ],
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
