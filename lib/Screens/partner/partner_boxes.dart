import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:saverapp/Services/partners.dart';
import 'package:saverapp/widget/box_list_view_partner.dart';

import '../../Models/boxs.dart';
import '../../Services/users.dart';
import '../../widget/adresseField.dart';
import '../../widget/box_list_view.dart';
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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              FutureBuilder<List<Box>>(
                future: PartnersService.getPartnerBoxes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // print(snapshot.data![0].id);
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const SearchField(),
                        const SizedBox(height: 30.0),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "All boxes available",
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
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Recommended for you",
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
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.green[800]!),
                        strokeWidth: 5,
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
