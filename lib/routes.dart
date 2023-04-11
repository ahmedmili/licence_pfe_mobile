import 'package:get/get.dart';

import 'package:saverapp/Screens/login.dart';
import 'package:saverapp/Screens/welcome.dart';

import 'package:saverapp/Screens/partner/register_partner.dart';

import 'package:saverapp/Screens/user/home.dart';
import 'package:saverapp/Screens/partner/home_.dart' as partnerHome;
import 'package:saverapp/Screens/user/main_page.dart';
import 'package:saverapp/Screens/user/registeruser.dart';
// import 'package:saverapp/middelwares/auth.dart';
// import 'package:saverapp/middelwares/checkRole.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
    name: '/',
    page: () => const Welcome(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(seconds: 1),
    // middlewares: [AuthMiddleware("any")],
  ),
  GetPage(
    name: '/login',
    page: () => const LoginScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(seconds: 1),
    // middlewares: [RoleMiddleware("user")],
  ),
  GetPage(
    name: '/registerPartner',
    page: () => const RegisterPartnerScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(seconds: 1),
  ),
  GetPage(
    name: '/registerUser',
    page: () => const RegisterUserScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(seconds: 1),
  ),
  GetPage(
    name: '/main',
    page: () => const MainScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(seconds: 1),
    // middlewares: [
    //   AuthMiddleware("any"),
    // ],
  ),
  GetPage(
    name: '/home',
    page: () => const HomeScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(seconds: 1),
    // middlewares: [
    //   AuthMiddleware("user"),
    // ],
  ),
  GetPage(
    name: '/partnerHome',
    page: () => const partnerHome.HomeScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(seconds: 1),
    // middlewares: [
    //   AuthMiddleware("partner"),
    // ],
  ),
];
