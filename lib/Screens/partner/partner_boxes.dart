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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              Container(
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      StatusWidget(status: "ACCEPTED"),
                      const SizedBox(width: 0),
                      StatusWidget(status: "PENDING"),
                      const SizedBox(width: 0),
                      StatusWidget(status: "FINISHED"),
                      const SizedBox(width: 0),
                      StatusWidget(status: "EXPIRED"),
                      const SizedBox(width: 0),
                      StatusWidget(status: "REJECTED"),
                    ],
                  ),
                ),
              ),
              FutureBuilder<List<Box>>(
                future: PartnersService.PartnerBoxsbystatus("ACCEPTED"),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 200, // or any other fixed height
                          child: BoxScreenPartner(items: snapshot.data!),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              FutureBuilder<List<Box>>(
                future: PartnersService.PartnerBoxsbystatus("PENDING"),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 200, // or any other fixed height
                          child: BoxScreenPartner(items: snapshot.data!),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              FutureBuilder<List<Box>>(
                future: PartnersService.PartnerBoxsbystatus("FINISHED"),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 200, // or any other fixed height
                          child: BoxScreenPartner(items: snapshot.data!),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              FutureBuilder<List<Box>>(
                future: PartnersService.PartnerBoxsbystatus("EXPIRED"),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 200,
                          child: BoxScreenPartner(items: snapshot.data!),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              FutureBuilder<List<Box>>(
                future: PartnersService.PartnerBoxsbystatus("REJECTED"),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 200,
                          child: BoxScreenPartner(items: snapshot.data!),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
