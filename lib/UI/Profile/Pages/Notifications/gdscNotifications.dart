// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';

class GDSCNotifications extends StatefulWidget {
  const GDSCNotifications({Key? key}) : super(key: key);

  @override
  State<GDSCNotifications> createState() => _GDSCNotificationsState();
}

class _GDSCNotificationsState extends State<GDSCNotifications> {
  final controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor:
              controller.isDark.value ? Colors.grey[900] : Colors.white,
          appBar: AppBar(
            //leading: const Icon(Icons.home, size: 20,color: Colors.black87,),
            iconTheme: IconThemeData(
                color:
                    controller.isDark.value ? Colors.white : Colors.grey[900],
                size: 20),
            backgroundColor:
                controller.isDark.value ? Colors.grey[900] : Colors.white,
            title: Components.header_3("Notifications",
                controller.isDark.value ? Colors.white : Colors.black87),
            elevation: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(children: [
                  notificationCard(
                      iconName: Icons.event,
                      action: "Event",
                      widget: Switch(
                          trackColor: MaterialStateProperty.all(
                              controller.isDark.value
                                  ? Colors.white
                                  : Colors.black54),
                          thumbColor:
                              MaterialStateProperty.all(Colors.deepOrange),
                          value: controller.isEventEnabled.value,
                          onChanged: ((value) {
                            controller.isEventEnabled.value = value;
                            print(value);
                            setState(() {});
                          }))),
                  Components.showDividerLine(2),
                  notificationCard(
                      iconName: Icons.layers,
                      action: "Resources",
                      widget: Switch(
                          trackColor: MaterialStateProperty.all(
                              controller.isDark.value
                                  ? Colors.white
                                  : Colors.black54),
                          thumbColor:
                              MaterialStateProperty.all(Colors.deepOrange),
                          value: controller.isResourceEnabled.value,
                          onChanged: ((value) {
                            controller.isResourceEnabled.value = value;
                            print(value);
                            setState(() {});
                          }))),
                  Components.showDividerLine(2),
                  notificationCard(
                      iconName: Icons.notifications_active,
                      action: "Announcements",
                      widget: Switch(
                          trackColor: MaterialStateProperty.all(
                              controller.isDark.value
                                  ? Colors.white
                                  : Colors.black54),
                          thumbColor:
                              MaterialStateProperty.all(Colors.deepOrange),
                          value: controller.isAnnouncementEnabled.value,
                          onChanged: ((value) {
                            controller.isAnnouncementEnabled.value = value;
                            print(value);
                            setState(() {});
                          }))),
                          Components.showDividerLine(2),
                  notificationCard(
                      iconName: Icons.missed_video_call_outlined,
                      action: "Meetings",
                      widget: Switch(
                          trackColor: MaterialStateProperty.all(
                              controller.isDark.value
                                  ? Colors.white
                                  : Colors.black54),
                          thumbColor:
                              MaterialStateProperty.all(Colors.deepOrange),
                          value: controller.isMeetingEnabled.value,
                          onChanged: ((value) {
                            controller.isMeetingEnabled.value = value;
                            print(value);
                            setState(() {});
                          }))),
                          Components.showDividerLine(2),
                  notificationCard(
                      iconName: Icons.person,
                      action: "Leads",
                      widget: Switch(
                          trackColor: MaterialStateProperty.all(
                              controller.isDark.value
                                  ? Colors.white
                                  : Colors.black54),
                          thumbColor:
                              MaterialStateProperty.all(Colors.deepOrange),
                          value: controller.isLeadsEnabled.value,
                          onChanged: ((value) {
                            controller.isLeadsEnabled.value = value;
                            print(value);
                            setState(() {});
                          }))),
                ]),
              ),
            ),
          ),
        ));
  }

  Widget notificationCard(
      {required IconData iconName,
      required String action,
      required Widget widget}) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.06,
      child: Row(
        children: [
          Row(
            children: [
              Icon(
                iconName,
                size: 18,
                color: controller.isDark.value ? Colors.white : Colors.black87,
              ),
              const SizedBox(width: 15),
              Components.header_3(action,
                  controller.isDark.value ? Colors.white : Colors.black87),
            ],
          ),
          Expanded(child: Container()),
          widget
        ],
      ),
    );
  }
}
