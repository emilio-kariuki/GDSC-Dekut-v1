import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/app_controller.dart';

class Resources extends StatefulWidget {
  const Resources({Key? key}) : super(key: key);

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  final controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor:
              controller.isDark.value ? Colors.grey[900] : Colors.white,
          body: Center(
            child: Text('Resources'),
          ),
        ));
  }
}
