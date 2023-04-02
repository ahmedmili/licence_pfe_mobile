import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/partners_service.dart';

import '../model/boxs.dart';
import '../widget/boxCard.dart';

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
    // getPartnerBoxs();
  }

  // Future<void> getPartnerBoxs() async {
  //   try {
  //     List<Box> response = await PartnersService.getBoxs(token);
  // List<dynamic> responseList = jsonDecode(response.body);
  // ignore: unused_local_variable
  // print(response);
  //     for (var responseMap in response) {
  //       print(responseMap.description);
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  Future<void> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Box>>(
      future: PartnersService.getBoxs(token),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final box = snapshot.data![index];
              return
                  // ListTile(
                  //   title: Text(box.title),
                  //   subtitle: Text(box.category),
                  // );
                  BoxCard(
                image: box.image,
                title: box.title,
                description: box.description,
                newPrice: box.newprice,
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
  }
}
