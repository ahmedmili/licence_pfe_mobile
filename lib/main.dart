import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Services/Firebase_notification_services.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'package:saverapp/Services/globals.dart';
import 'package:saverapp/routes.dart';
import 'package:saverapp/translator/En.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_core/firebase_core.dart';

// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(GlobalController());
  Get.put(GeoLocatorController());
  GlobalController controller = Get.find<GlobalController>();
  GeoLocatorController geoController = Get.find<GeoLocatorController>();

  await controller.readRole();
  await controller.readToken();
  Future.delayed(const Duration(milliseconds: 500), () async {
    await geoController.getLocation();
    await geoController.getAddressFromLatLng();
  }); //0.5 seconds
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final FirebaseMessagingService _notificationHandler =
      FirebaseMessagingService();
  @override
  void initState() {
    _notificationHandler.setupFirebaseMessaging();
    super.initState();
  }

  @override
  void dispose() {
    // Cleanup operations: cancel subscriptions, release resources, dispose controllers, etc.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _notificationHandler.initialize();

    return GetMaterialApp(
      // translation config
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),

      debugShowCheckedModeBanner: false,
      initialRoute: '/splash-page',
      getPages: routes,
    );
  }
}
