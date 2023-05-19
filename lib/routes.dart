import 'package:get/get.dart';
import 'package:saverapp/Screens/change_password.dart';
import 'package:saverapp/Screens/code.dart';
import 'package:saverapp/Screens/login.dart';
import 'package:saverapp/Screens/partner/nav_bottom.dart';
import 'package:saverapp/Screens/welcome.dart';
import 'package:saverapp/Screens/partner/register_partner.dart';
import 'package:saverapp/Screens/user/home.dart';
import 'package:saverapp/Screens/user/main_page.dart';
import 'package:saverapp/Screens/user/registeruser.dart';
import 'package:saverapp/widget/google_map.dart';
import 'package:saverapp/widget/partnerDetails.dart';
import 'Screens/partner/home_partner.dart';

import 'package:saverapp/middelwares/auth.dart';
// import 'package:saverapp/middelwares/checkRole.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
    name: '/',
    page: () => const Welcome(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 700),
    middlewares: [AuthMiddleware("any")],
  ),
  GetPage(
    name: '/login',
    page: () => const LoginScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/registerPartner',
    page: () => const RegisterPartnerScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/registerUser',
    page: () => const RegisterUserScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/main',
    page: () => const MainScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/home',
    page: () => const HomeScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/partnerHome',
    page: () => const HomePartnerScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/partnerMain',
    page: () => const NavBottomScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/verifPasswordCode',
    page: () => const Code(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/changePassword',
    page: () => const ChangePassword(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/maps',
    page: () => const MapSample(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/partnerdetails',
    page: () => const PartnerDetails(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
];
