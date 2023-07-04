// ignore_for_file: file_names

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void setupFirebaseMessaging() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not yet granted permission');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: ${message.notification!.title}');
      // Handle foreground notifications here
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp: ${message.notification!.title}');
      // Handle notification when app is in background and opened
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
      print('onBackgroundMessage: ${message.notification!.title}');
      // Handle background notifications here
      return Future<void>.value();
    });

    String? token = await _firebaseMessaging.getToken();
    print('Firebase Token: $token');
    // Send the token to your server for further processing
  }

  Future initialize() async {
    // Request permission and get the FCM token
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();

    print('------------------------------------------------');
    print('FCM Token: $token');

    // Configure FCM message handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.body}');
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<dynamic> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }
}
