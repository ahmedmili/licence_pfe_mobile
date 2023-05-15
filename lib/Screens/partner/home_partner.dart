import 'package:flutter/material.dart';
import 'package:saverapp/Models/order.dart';
import 'package:saverapp/dimensions.dart';

import '../../Services/partners.dart';
import '../../widget/order_list_view_partner.dart';

class HomePartnerScreen extends StatefulWidget {
  const HomePartnerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePartnerScreenState createState() => _HomePartnerScreenState();
}

class _HomePartnerScreenState extends State<HomePartnerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: Dimensions.width20),
          child: Text(
            "Orders :",
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
      body: Column(
        children: [
          SizedBox(height: Dimensions.height10),
          FutureBuilder<List<Order>>(
            future: PartnersService.getPartnerOrders(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 35),
                    width: 340,
                    child: OrderScreenPartner(
                      items: snapshot.data!,
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
          ),
        ],
      ),
    );
  }
}
