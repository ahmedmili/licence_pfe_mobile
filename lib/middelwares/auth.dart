import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Services/globals.dart';

class AuthMiddleware extends GetMiddleware {
  final String roleType;

  AuthMiddleware(this.roleType) {
    priority = 2;
  }

  @override
  RouteSettings? redirect(String? route) {
    GlobalController controller = Get.find<GlobalController>();

    bool isAuthenticated = controller.token.isNotEmpty;
    bool role = (controller.role == roleType);

    if (!isAuthenticated) {
      // return const RouteSettings(name: '/main')
      //controller.logout();
      return null;
    } else {
      if (!role) {
        if (controller.role == "user") {
          return const RouteSettings(name: '/main');
        }
        if (controller.role == "partner") {
          return const RouteSettings(name: '/partnerMain');
        }
      }
    }
    return null;
  }
}
