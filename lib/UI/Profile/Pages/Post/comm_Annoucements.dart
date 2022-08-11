import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/app_controller.dart';


class CommunityAnnoucements extends StatefulWidget {
  const CommunityAnnoucements({Key? key}) : super(key: key);

  @override
  State<CommunityAnnoucements> createState() => _CommunityAnnoucementsState();
}

class _CommunityAnnoucementsState extends State<CommunityAnnoucements> {
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
