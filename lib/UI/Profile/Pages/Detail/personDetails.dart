import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/app_controller.dart';
import '../../../../Util/App_components.dart';

class Persona extends StatefulWidget {
  const Persona({Key? key}) : super(key: key);

  @override
  State<Persona> createState() => _PersonaState();
}

class _PersonaState extends State<Persona> {
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
          title: Components.header_3("Profile Details", controller.isDark.value ? Colors.white : Colors.black87),
          elevation: 0,
        ),

        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                
              ]),
            )),
      ),);
  }
}
