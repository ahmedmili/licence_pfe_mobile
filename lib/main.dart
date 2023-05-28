import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saverapp/Services/geoLocator.dart';
import 'package:saverapp/Services/globals.dart';
import 'package:saverapp/routes.dart';
import 'package:saverapp/translator/En.dart';

void main() async {
  Get.put(GlobalController());
  Get.put(GeoLocatorController());

  GlobalController controller = Get.find<GlobalController>();
  GeoLocatorController geoController = Get.find<GeoLocatorController>();

  WidgetsFlutterBinding.ensureInitialized();

  await controller.readRole();
  await controller.readToken();

  Future.delayed(const Duration(milliseconds: 500), () async {
    await geoController.getLocation();
    await geoController.getAddressFromLatLng();
  }); //0.5 seconds

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // translation config
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      // localizationsDelegates: const [

      debugShowCheckedModeBanner: false,
      initialRoute: '/splash-page',
      getPages: routes,
    );
  }
}
