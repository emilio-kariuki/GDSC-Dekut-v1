import 'package:flutter/material.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controller/app_controller.dart';

int itemCount = 5;

class Meeting extends StatefulWidget {
  const Meeting({Key? key}) : super(key: key);

  @override
  State<Meeting> createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final controller = Get.put(AppController());
  int initCount = 5;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      itemCount = controller.docsLength.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.isDark.value ? Colors.grey[900] : Colors.white,
        appBar: AppBar(
          // leading: const Icon(Icons.home, size: 20,color: Colors.black87,),
          backgroundColor:
              controller.isDark.value ? Colors.grey[900] : Colors.white,
          title: Components.header_3("Virtual Meetings",
              controller.isDark.value ? Colors.white : Colors.black87),
          elevation: 0,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          //physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Components.meetingListSlider(context),
              ),

              //Components.spacerHeight(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "upcoming Meetings",
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 22,
                      color: controller.isDark.value
                          ? Colors.white
                          : Colors.black),
                ),
              ),
              Components.spacerHeight(8),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 35),
              //   child: Components.showDividerLine(),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Components.meetingListCard(context),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
