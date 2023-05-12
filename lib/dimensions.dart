import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // formula of factor calculation
  // height/widht

  // 844/220 = 3.840

  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;
  //dynamic height padding and margin
  // 844/10=84
  static double height10 = screenHeight / 84.4;
  //844/15=56
  static double height15 = screenHeight / 56.27;
  //844/20=42.2
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;
  static double height50 = screenHeight / 16.88;
  static double height60 = screenHeight / 14.06;
  static double height70 = screenHeight / 12.05;

//font size
  static double font20 = screenHeight / 42.2;
  static double font16 = screenHeight / 52.75;
  static double font26 = screenHeight / 32.46;
  static double font28 = screenHeight / 30.14;

  //radius
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;
  static double radius15 = screenHeight / 56.27;

  //dynamic width padding and margin
  // 844/10=84
  static double width10 = screenHeight / 84.4;
  //844/15=56
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;
  static double width40 = screenHeight / 21.1;
  static double width45 = screenHeight / 18.76;
  static double width50 = screenHeight / 16.88;
  static double width70 = screenHeight / 12.05;

  //icon size
  static double iconsSize = screenHeight / 35.17;
  static double iconsSize16 = screenHeight / 52.75;

  //list view size
  static double ListViewImgSize = screenWidth / 3.25;
  static double ListViewTextContSize = screenWidth / 3.9;

  //popular food
  static double popularFoodImgSize = screenHeight / 2.41;

//bottom height
  static double bottomHeightBar = screenHeight / 7.03;

//splash screen dimensions
  static double splashImg = screenHeight / 3.38;
}
