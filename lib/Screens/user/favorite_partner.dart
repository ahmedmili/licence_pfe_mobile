import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:saverapp/widget/partnerCard.dart';

class FavoritePartner extends StatefulWidget {
  const FavoritePartner({super.key});

  @override
  State<FavoritePartner> createState() => _FavoritePartnerState();
}

class _FavoritePartnerState extends State<FavoritePartner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          PartnerCard(),
        ],
      ),
    );
  }
}
