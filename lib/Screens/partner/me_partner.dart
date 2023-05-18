import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Screens/partner/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/partners.dart';
import '../../widget/Location_dropDawn.dart';

class MePartner extends StatefulWidget {
  const MePartner({super.key});

  @override
  State<MePartner> createState() => _MePartnerState();
}

class _MePartnerState extends State<MePartner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(height: 40),
          SizedBox(
            height: 20,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final card = profileCompletionCards[index];
                return SizedBox(
                  width: 190,
                  child: Card(
                    shadowColor: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Icon(
                            card.icon,
                            size: 30,
                            color: Colors.green[800],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            card.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Padding(padding: EdgeInsets.only(right: 5)),
              itemCount: profileCompletionCards.length,
            ),
          ),
          const SizedBox(height: 35),
          ...List.generate(
            customListTiles.length,
            (index) {
              final tile = customListTiles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: InkWell(
                  onTap: () {
                    tile.cb();
                  },
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: ListTile(
                      leading: Icon(tile.icon),
                      title: Text(tile.title),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
              child: Card(
            elevation: 4,
            shadowColor: Colors.black12,
            child: ListTile(
              leading: Icon(
                Icons.location_on_outlined,
              ),
              title: Text("Location"),
              trailing: PopupLocationMenu(),
            ),
          )
              // child: PopupLocationMenu()),
              ),
        ],
      ),
    );
  }
}

class ProfileCompletionCard {
  final String title;
  final IconData icon;
  ProfileCompletionCard({
    required this.title,
    required this.icon,
  });
}

List<ProfileCompletionCard> profileCompletionCards = [];

class CustomListTile {
  // ignore: prefer_typing_uninitialized_variables
  final dynamic cb;
  final IconData icon;
  final String title;
  CustomListTile({
    required this.cb,
    required this.icon,
    required this.title,
  });
  dynamic get age {
    return cb;
  }
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    cb: () {
      Get.to(() => const ProfilePartner());
    },
    icon: Icons.person_2_outlined,
    title: "Profile",
  ),
  // CustomListTile(
  //   cb: () {
  //     // return const Text("00");
  //   },
  //   icon: Icons.location_on_outlined,
  //   title: "Location",
  // ),
  // ExponsionPanel

  CustomListTile(
    cb: () async {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      var res = await PartnersService.logout();
      // if (res.statusCode == 200) {
      _pref.setString("token", "");
      _pref.setString("role", "");
      controller.setToken("");
      controller.setRole("");

      Get.offAllNamed("/");
      // }
    },
    title: "Logout",
    icon: CupertinoIcons.arrow_right_arrow_left,
  ),
];
