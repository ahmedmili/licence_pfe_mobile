import 'package:flutter/material.dart';

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
        children: const [
          SizedBox(height: 20),
          PartnerCard(),
        ],
      ),
    );
  }
}
