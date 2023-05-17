import 'package:flutter/material.dart';
import 'package:saverapp/Services/partners.dart';
import 'package:saverapp/widget/box_list_view_partner.dart';
import '../../Models/boxs.dart';
import '../../dimensions.dart';
import '../../widget/searchField.dart';

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
              FutureBuilder<List<Box>>(
                future: PartnersService.getPartnerBoxesAccepted(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Boxes on sale",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "View all",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[800]),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.green[800],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15.0),
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
                future: PartnersService.getPartnerBoxesPending(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Pending boxes",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "View all",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[800]),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.green[800],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15.0),
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
                future: PartnersService.getPartnerBoxsFinished(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Finished boxes",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "View all",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[800]),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.green[800],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15.0),
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
                future: PartnersService.getPartnerBoxsExpired(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Expired boxes",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "View all",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[800]),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.green[800],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15.0),
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
                future: PartnersService.getPartnerBoxsRejected(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Rejected boxes",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "View all",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[800]),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.green[800],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15.0),
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
            ],
          ),
        ],
      ),
    );
  }
}
