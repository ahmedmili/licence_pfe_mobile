import 'package:flutter/material.dart';
import 'package:saverapp/Services/partners.dart';
import 'package:saverapp/widget/box_list_view_partner.dart';
import '../../Models/boxs.dart';
import '../../dimensions.dart';
import '../../widget/searchField.dart';
import '../../widget/statuswidget.dart';

class PartnerBoxes extends StatefulWidget {
  const PartnerBoxes({super.key});

  @override
  State<PartnerBoxes> createState() => _PartnerBoxesState();
}

class _PartnerBoxesState extends State<PartnerBoxes> {
  String _selectedStatus = "ACCEPTED";

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
          child: const Text(
            "Your Boxes :",
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
          Container(
            height: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  StatusWidget(
                    status: "ACCEPTED",
                    isSelected: _selectedStatus == "ACCEPTED",
                    onStatusSelected: _onStatusSelected,
                  ),
                  const SizedBox(width: 0),
                  StatusWidget(
                    status: "PENDING",
                    isSelected: _selectedStatus == "PENDING",
                    onStatusSelected: _onStatusSelected,
                  ),
                  const SizedBox(width: 0),
                  StatusWidget(
                    status: "FINISHED",
                    isSelected: _selectedStatus == "FINISHED",
                    onStatusSelected: _onStatusSelected,
                  ),
                  const SizedBox(width: 0),
                  StatusWidget(
                    status: "REJECTED",
                    isSelected: _selectedStatus == "REJECTED",
                    onStatusSelected: _onStatusSelected,
                  ),
                  const SizedBox(width: 0),
                  StatusWidget(
                    status: "EXPIRED",
                    isSelected: _selectedStatus == "EXPIRED",
                    onStatusSelected: _onStatusSelected,
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder<List<Box>>(
            future: PartnersService.PartnerBoxsbystatus(_selectedStatus),
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
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 150),
                      Container(
                        height: 200,
                        width: 200,
                        child: Image(
                          image: AssetImage("assets/images/box.png"),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Add some boxes.",
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
