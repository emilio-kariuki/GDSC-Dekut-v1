import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';


class AdminResources extends StatefulWidget {
  const AdminResources({Key? key}) : super(key: key);

  @override
  State<AdminResources> createState() => _AdminResourcesState();
}

class _AdminResourcesState extends State<AdminResources> {
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
          title: Components.header_3("Resources", controller.isDark.value ? Colors.white : Colors.black87),
          elevation: 0,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
              child: Components.adminResourceListCard(context),
            )),
      ),);
  }
}
