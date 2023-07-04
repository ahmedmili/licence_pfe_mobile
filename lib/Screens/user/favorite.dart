import 'package:flutter/material.dart';
import 'package:saverapp/Models/boxs.dart';
import 'package:saverapp/Services/users.dart';
import 'package:saverapp/widget/box_list_view.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          FutureBuilder<List<Box>>(
            future: UserService.favorsBoxs(),
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
                    margin: const EdgeInsets.only(left: 35),
                    width: 340,
                    child: BoxScreen(
                      items: snapshot.data!,
                      directions: "V",
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 190),
                      const SizedBox(
                        height: 200,
                        width: 200,
                        child: Image(
                          image: AssetImage("assets/images/favoris.png"),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "No favorites found.",
                        style: TextStyle(
                            fontSize: 20,
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
