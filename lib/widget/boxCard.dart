import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BoxCard extends StatelessWidget {
  BoxCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.newPrice,
  });

  String image;
  String title;
  String description;
  String newPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 265,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 247, 236, 236),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              offset: const Offset(0, 3),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.network(
                "http://10.0.2.2:8000/storage/boxs_imgs/$image",
                height: 150,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  newPrice,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                  size: 28,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
