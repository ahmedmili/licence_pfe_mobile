import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Models/order.dart';
import 'package:saverapp/dimensions.dart';
import 'package:saverapp/widget/statuswidget.dart';

import '../../Services/partners.dart';
import '../../widget/order_list_view_partner.dart';

class HomePartnerScreen extends StatefulWidget {
  const HomePartnerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePartnerScreenState createState() => _HomePartnerScreenState();
}

class _HomePartnerScreenState extends State<HomePartnerScreen> {
  String _selectedStatus = "pending";

  void _onStatusSelected(String status) {
    setState(() {
      _selectedStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: Dimensions.width20),
          child: Text(
            "${"orders".tr}:",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
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
          SizedBox(
            height: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  StatusWidget(
                    status: "pending",
                    isSelected: _selectedStatus == "pending",
                    onStatusSelected: _onStatusSelected,
                  ),
                  const SizedBox(width: 0),
                  StatusWidget(
                    status: "success",
                    isSelected: _selectedStatus == "success",
                    onStatusSelected: _onStatusSelected,
                  ),
                  const SizedBox(width: 0),
                  StatusWidget(
                    status: "cancel",
                    isSelected: _selectedStatus == "cancel",
                    onStatusSelected: _onStatusSelected,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Order>>(
              future: PartnersService.getPartnerOrders(_selectedStatus),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.green[800]!),
                      strokeWidth: 5,
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return OrderScreenPartner(
                    items: snapshot.data!,
                  );
                } else if (snapshot.hasError) {
                  return Text('${'Error'.tr} : ${snapshot.error}');
                } else {
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 150),
                        const SizedBox(
                          height: 200,
                          width: 200,
                          child: Image(
                            image: AssetImage("assets/images/order.png"),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          ("No_orders".tr).toUpperCase(),
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.orange.shade900,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
