import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/app_controller.dart';


class CommunityResources extends StatefulWidget {
  const CommunityResources({Key? key}) : super(key: key);

  @override
  State<CommunityResources> createState() => _CommunityResourcesState();
}

class _CommunityResourcesState extends State<CommunityResources> {
  final controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.isDark.value ? Colors.grey[900] : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(child: Text("Annoucements"),)
        ),
      ),
    );
  }
}
