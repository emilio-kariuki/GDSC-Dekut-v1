// ignore_for_file: unused_local_variable, avoid_print

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/UI/Announcement/UI/announcement.dart';
import 'package:gdsc_app/UI/Meetings/UI/meetings.dart';
import 'package:gdsc_app/UI/Profile/profile.dart';
import 'package:gdsc_app/UI/Resources/UI/resources.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:gdsc_app/main.dart';
import 'package:get/get.dart';

import '../../Util/dimensions.dart';
import '../Events/UI/Events.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(AppController());
  int activeIndex = 0;
  var myGroup = AutoSizeGroup();

  @override
  void initState() {
    super.initState();
    controller.fetchEvents();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    controller.getTechology();
    controller.getProfileImage();
    controller.getProfileDetails();
    controller.getThemeStatus();
    Firebase.initializeApp();
    Components.flutterNotificationSettings();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    controller.getPassword();
    controller.getProfileImage();
    String? token = await FirebaseMessaging.instance.getToken();
    print("Token of the app is :$token");
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor:
              controller.isDark.value ? Colors.white : Colors.black87,
          body: getBody(),
          bottomNavigationBar: getFooter(),
        ));
  }

  Widget getFooter() {
    List<IconData> icons = [
      Icons.home,
      Icons.layers,
      Icons.notifications,
      Icons.missed_video_call_outlined,
      Icons.person,
    ];
    List<String> names = [
      "Events",
      "Resources",
      "News",
      "Meeting",
      "Profile",
    ];
    return AnimatedBottomNavigationBar.builder(
      elevation: 0,
      backgroundColor:
          controller.isDark.value ? Colors.grey[900] : Colors.white,
      splashColor: Colors.deepOrangeAccent,
      notchSmoothness: NotchSmoothness.softEdge,
      itemCount: icons.length,
      activeIndex: activeIndex,
      gapWidth: 10,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
      tabBuilder: (int index, bool isActive) {
        final color = isActive
            ? Colors.deepOrange
            : controller.isDark.value
                ? Colors.white
                : Colors.black54;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icons[index],
              size: 18,
              color: color,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AutoSizeText(
                names[index],
                maxLines: 1,
                style: TextStyle(color: color, fontWeight: FontWeight.w500),
                group: myGroup,
              ),
            )
          ],
        );
      },
    );
  }

  selectedTab(index) {
    setState(() {
      activeIndex = index;
    });
  }

  Widget getBody() {
    List<Widget> pages = [
      const Events(),
      const Resources(),
      const Announcements(),
      const Meeting(),
      const Account(),
    ];
    return IndexedStack(
      index: activeIndex,
      children: pages,
    );
  }
}
