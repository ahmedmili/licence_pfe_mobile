// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Services/globals.dart';
import 'package:saverapp/Services/users.dart';

class NeuButtonPartner extends StatefulWidget {
  const NeuButtonPartner({
    super.key,
    // required this.partnerid,
    // required this.isLiked,
  });
  // final onTap;
  // final int partnerid;
  // final bool isLiked;

  @override
  State<NeuButtonPartner> createState() => _NeuButtonPartnerState();
}

class _NeuButtonPartnerState extends State<NeuButtonPartner> {
  GlobalController controller = Get.find();

  Future<void> buttonPresssed() async {
    await UserService.likeOrDislikePartner(controller.partner.id);

    setState(() {
      controller.partner.likes = !controller.partner.likes!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => buttonPresssed(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(35),
          boxShadow: controller.partner.likes!
              ? [
                  BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(6, 6),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                  const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-6, -6),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                ]
              : [],
        ),
        child: Icon(
          Icons.favorite,
          size: 20,
          color: controller.partner.likes! ? Colors.red[400] : Colors.grey,
        ),
      ),
    );
  }
}
