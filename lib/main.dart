// ignore_for_file: non_constant_identifier_names, unused_element, avoid_print

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gdsc_app/InternetConnection/chechConnection.dart';
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
String? token;
getToken() async {
  token = (await FirebaseMessaging.instance.getToken())!;
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await FirebaseMessaging.instance.subscribeToTopic("Name");

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

  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();

  Get.lazyPut<AppController>(() => AppController(), fenix: true);

   AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
    null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'base',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  await AwesomeNotifications().actionStream.listen(
    (ReceivedNotification receivedNotification){


        Navigator.of(Get.context!).pushNamed(
            '/NotificationPage',
            arguments: {
                // your page params. I recommend you to pass the
                // entire *receivedNotification* object
                //id: receivedNotification.id,
            }
        );

    }
);

  runApp(MyApp());
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'this channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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
