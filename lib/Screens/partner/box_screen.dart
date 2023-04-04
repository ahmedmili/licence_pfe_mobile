import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/partners_service.dart';

import '../../model/boxs.dart';
import '../../widget/boxCard.dart';

class BoxScreen extends StatefulWidget {
  const BoxScreen({Key? key}) : super(key: key);

  @override
  State<BoxScreen> createState() => _BoxScreenState();
}

class _BoxScreenState extends State<BoxScreen> {
  late String token;
  @override
  void initState() {
    super.initState();
    readToken();
  }

  Future<String> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "0";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: readToken(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder<List<Box>>(
            future: PartnersService.getBoxs(snapshot.data!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final box = snapshot.data![index];
                    return Container(
                      child: BoxCard(
                        image: box.image,
                        title: box.title,
                        description: box.description,
                        newPrice: box.newprice,
                        oldPrice: box.oldprice,
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
