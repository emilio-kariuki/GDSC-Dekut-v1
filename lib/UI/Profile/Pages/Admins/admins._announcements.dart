import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';


class AdminAnnouncements extends StatefulWidget {
  const AdminAnnouncements({Key? key}) : super(key: key);

  @override
  State<AdminAnnouncements> createState() => _AdminAnnouncementsState();
}

class _AdminAnnouncementsState extends State<AdminAnnouncements> {
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
          title: Components.header_3("Announcements", controller.isDark.value ? Colors.white : Colors.black87),
          elevation: 0,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Components.adminAnnouncementListCard(context),
            )),
      ),);
  }
}
