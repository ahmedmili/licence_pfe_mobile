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
              if (snapshot.hasData) {
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
          ),
        ],
      ),
    );
  }
}
