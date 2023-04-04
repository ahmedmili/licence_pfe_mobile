import 'package:flutter/material.dart';
import 'package:saverapp/model/boxs.dart';

// ignore: must_be_immutable
class BoxCard extends StatelessWidget {
  BoxCard(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.newPrice,
      required this.oldPrice});

  String image;
  String title;
  String description;
  String newPrice;
  String oldPrice;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            width: 340.0,
            child: Image.network(
              "http://10.0.2.2:8000/storage/boxs_imgs/$image",
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Container(
              height: 60.0,
              width: 340.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black12],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10.0,
            bottom: 10.0,
            right: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: <Widget>[
                    Text(
                      oldPrice,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      newPrice,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
        // decoration: BoxDecoration(
        //     color: const Color.fromARGB(255, 247, 236, 236),
        //     borderRadius: BorderRadius.circular(15),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey.withOpacity(0.5),
        //         spreadRadius: 3,
        //         offset: const Offset(0, 3),
        //       ),
        //     ]),
        // child: Padding(
        //   padding: const EdgeInsets.symmetric(
        //     horizontal: 10,
        //   ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Container(
        //       alignment: Alignment.center,
        //       child: Image.network(
        //         "http://10.0.2.2:8000/storage/boxs_imgs/$image",
        //         height: 150,
        //       ),
        //     ),
        //     Text(
        //       title,
        //       style: const TextStyle(
        //         fontSize: 23,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 2,
        //     ),
        //     Text(
        //       description,
        //       style: const TextStyle(
        //         fontSize: 16,
        //       ),
        //     ),
        // const SizedBox(
        //   height: 2,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       newPrice,
        //       style: const TextStyle(
        //         fontSize: 18,
        //         color: Colors.grey,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     Text(
        //       oldPrice,
        //       style: const TextStyle(
        //         fontSize: 18,
        //         color: Colors.grey,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     const Icon(
        //       Icons.favorite_border,
        //       color: Colors.red,
        //       size: 28,
        //     ),
        // ],
      ),
    );
  }
}
