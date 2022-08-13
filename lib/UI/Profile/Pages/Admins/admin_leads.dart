import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';


class AdminLeads extends StatefulWidget {
  const AdminLeads({Key? key}) : super(key: key);

  @override
  State<AdminLeads> createState() => _AdminLeadsState();
}

class _AdminLeadsState extends State<AdminLeads> {
  final controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor:
            controller.isDark.value ? Colors.grey[900] : Colors.white,
       
        body: SafeArea(
            child: SingleChildScrollView(
              child: Components.adminLeadsListCard(context),
            )),
      ),);
  }
}
