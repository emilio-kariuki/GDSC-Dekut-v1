import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:get/get.dart';

import '../../../Util/App_components.dart';

class Announcements extends StatefulWidget {
  const Announcements({Key? key}) : super(key: key);

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  final controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor:
            controller.isDark.value ? Colors.grey[900] : Colors.white,
        appBar: AppBar(
          // leading: const Icon(Icons.home, size: 20,color: Colors.black87,),
          backgroundColor:
              controller.isDark.value ? Colors.grey[900] : Colors.white,
          title: Components.header_3("News", controller.isDark.value ? Colors.white : Colors.black87),
          elevation: 0,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("."),
                  Components.announcementListCard(context),
                ],
              ),
            )),
      ),);
  }
}
