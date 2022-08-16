import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';


class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
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
          title: Components.header_3("Help", controller.isDark.value ? Colors.white : Colors.black87),
          centerTitle: true,
          elevation: 0,
        ),
        
        body: SafeArea(
            child: SingleChildScrollView(
              child: Components.leadListCard(context),
            )),
      ),);
  }
}
