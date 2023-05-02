import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'package:saverapp/Services/globals.dart';
import 'package:saverapp/routes.dart';

void main() async {
  Get.put(GlobalController());
  Get.put(GeoLocatorController());

  GlobalController controller = Get.find<GlobalController>();

  // WidgetsFlutterBinding.ensureInitialized();
  await controller.readRole();
  await controller.readToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Get.put(GlobalController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: routes,
    );
  }
}
