import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Screens/user/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/auth.dart' as auth;
import '../../Services/users.dart';

class MeScreen extends StatefulWidget {
  const MeScreen({super.key});

  @override
  State<MeScreen> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: UserService.getUserStats(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const SizedBox(height: 40),
                SizedBox(
                  height: 180,
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
                                const SizedBox(height: 10),
                                Text(
                                  snapshot.data![card.type].toString(),
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
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green[800]!),
                strokeWidth: 5,
              ),
            );
          }
        },
      ),
    );
  }
}

class ProfileCompletionCard {
  final String title;
  final String type;
  final IconData icon;
  ProfileCompletionCard({
    required this.title,
    required this.type,
    required this.icon,
  });
}

List<ProfileCompletionCard> profileCompletionCards = [
  ProfileCompletionCard(
    title: "Savings made",
    type: "savedMoney",
    icon: CupertinoIcons.money_dollar,
  ),
  ProfileCompletionCard(
    title: "Boxes saved",
    type: "savedBoxs",
    icon: CupertinoIcons.cube_box,
  ),
];

class CustomListTile {
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
      Get.to(() => const ProfileUser());
    },
    icon: Icons.person_2_outlined,
    title: "Profile",
  ),
  CustomListTile(
    cb: () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var res = await auth.AuthServices.logout();
      // if (res.statusCode == 200) {
      pref.setString("token", "");
      pref.setString("role", "");
      controller.setToken("");
      controller.setRole("");
      Get.offAllNamed("/");
      // }
    },
    title: "Logout",
    icon: CupertinoIcons.arrow_right_arrow_left,
  ),
];
