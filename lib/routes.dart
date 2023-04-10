import 'package:get/get.dart';

import 'package:saverapp/Screens/login.dart';
import 'package:saverapp/Screens/welcome.dart';

import 'package:saverapp/Screens/partner/register_partner.dart';

import 'package:saverapp/Screens/user/home.dart';
import 'package:saverapp/Screens/user/main_page.dart';
import 'package:saverapp/Screens/user/registeruser.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: '/', page: () => const Welcome()),
  GetPage(name: '/login', page: () => const LoginScreen()),
  GetPage(name: '/registerPartner', page: () => const RegisterPartnerScreen()),
  GetPage(name: '/registerUser', page: () => const RegisterUserScreen()),
  GetPage(name: '/main', page: () => const MainScreen()),
  GetPage(name: '/home', page: () => const HomeScreen()),
];
