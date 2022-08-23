// ignore_for_file: non_constant_identifier_names, unused_element, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gdsc_app/UI/Authentication/Login/login_page.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';


import 'Controller/app_controller.dart';
import 'UI/Authentication/user_logic.dart';
import 'UI/Home/Home.dart';

String userID = '';
User? the_User;
String userName = '';
String userEmail = '';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:  'this channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Get.lazyPut<AppController>(() => AppController(), fenix: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final controller = Get.put(AppController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: Authentication.initializeFirebase(context: context),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          User? user = FirebaseAuth.instance.currentUser;

          if (user != null) {

            return GetMaterialApp(
              debugShowCheckedModeBanner: false,

              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const Home(),
              color: Colors.blue,
            );
          } else {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const Login(),
              color: Colors.blue,
            );
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}
