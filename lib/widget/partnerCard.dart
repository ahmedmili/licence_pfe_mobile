// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:saverapp/Models/partner.dart';
import 'package:saverapp/Services/globals.dart';
import '../Services/users.dart';

class PartnerCard extends StatefulWidget {
  const PartnerCard({
    super.key,
  });

  @override
  State<PartnerCard> createState() => _PartnerCardState();
}

class _PartnerCardState extends State<PartnerCard> {
  List<Partner> favoredPartners = [];

  @override
  void initState() {
    super.initState();
    _getFavoredPartners();
  }

  Future<void> _getFavoredPartners() async {
    try {
      final partners = await UserService.favorsPartners();
      setState(() {
        favoredPartners = partners;
      });
    } catch (e) {
      print('Error fetching favored partners: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        favoredPartners.isNotEmpty
            ? SizedBox(
                height: 500,
                width: 450,
                child: ListView.builder(
                  itemCount: favoredPartners.length,
                  itemBuilder: (context, index) {
                    final partner = favoredPartners[index];
                    return Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Container(
                          height: 220,
                          width: 450,
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundImage: NetworkImage(
                                                "http://$localhost:8000/storage/partner_imgs/${partner.image}",
                                                headers: {
                                                  "Keep-Alive": "timeout=20",
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            partner.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          partner.category,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green[800]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,
                                          color: Colors.green[800]),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Address",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.phone,
                                          color: Colors.green[800]),
                                      const SizedBox(width: 10),
                                      Text(
                                        "${partner.phone}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.email_outlined,
                                          color: Colors.green[800]),
                                      const SizedBox(width: 10),
                                      Text(
                                        partner.email,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.access_alarm,
                                          color: Colors.green[800]),
                                      const SizedBox(width: 10),
                                      Text(
                                        "${partner.openingtime} -> ${partner.closingtime}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
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
                    );
                  },
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
