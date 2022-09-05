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
                child: Column(
                  children: [
                    InputField(hint: "Enter the title of the notification"),

                ]),
              ),
            ),
          ),
        ));
  }


}
