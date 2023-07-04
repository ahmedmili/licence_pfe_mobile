import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Services/partners.dart';
import 'package:saverapp/widget/box_list_view_partner.dart';
import '../../Models/boxs.dart';
import '../../dimensions.dart';
// import '../../widget/searchField.dart';
import '../../widget/statuswidget.dart';

class PartnerBoxes extends StatefulWidget {
  const PartnerBoxes({super.key});

  @override
  State<PartnerBoxes> createState() => _PartnerBoxesState();
}

class _PartnerBoxesState extends State<PartnerBoxes> {
  String _selectedStatus = "accepted";

  void _onStatusSelected(String status) {
    setState(() {
      _selectedStatus = status;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: Dimensions.width20),
          child: Text(
            "${("Your_Boxes".tr).toUpperCase()} :",
            style: const TextStyle(
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
          SizedBox(
            height: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  StatusWidget(
                    status: ("accepted"),
                    isSelected: _selectedStatus == "accepted",
                    onStatusSelected: _onStatusSelected,
                  ),
                  const SizedBox(width: 0),
                  StatusWidget(
                    status: "pending",
                    isSelected: _selectedStatus == "pending",
                    onStatusSelected: _onStatusSelected,
                  ),
                  const SizedBox(width: 0),
                  StatusWidget(
                    status: "finished",
                    isSelected: _selectedStatus == "finished",
                    onStatusSelected: _onStatusSelected,
                  ),
                  const SizedBox(width: 0),
                  StatusWidget(
                    status: "refused",
                    isSelected: _selectedStatus == "REJECTED",
                    onStatusSelected: _onStatusSelected,
                  ),
                  const SizedBox(width: 0),
                  StatusWidget(
                    status: "expired",
                    isSelected: _selectedStatus == "EXPIRED",
                    onStatusSelected: _onStatusSelected,
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder<List<Box>>(
            future: PartnersService.partnerBoxsbystatus(_selectedStatus),
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
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(30),
                    width: 340,
                    child: BoxScreenPartner(
                      items: snapshot.data!,
                      directions: "V",
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${"error".tr}: ${snapshot.error}');
              } else {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 150),
                      const SizedBox(
                        height: 200,
                        width: 200,
                        child: Image(
                          image: AssetImage("assets/images/box.png"),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        ("Add some boxes".tr),
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
        ],
      ),
    );
  }
}
