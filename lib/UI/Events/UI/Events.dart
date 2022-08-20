import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controller/app_controller.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final controller = Get.put(AppController());
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
          title: Components.header_3("Events", controller.isDark.value ? Colors.white : Colors.black87),
          elevation: 0,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
              //physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Components.eventListSlider(context),
                  ),

                  Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CarouselIndicator(
                    count: controller.docsLength.value,
                    index: controller.i.value,
                    animationDuration: 200,
                    color: const Color.fromARGB(255, 146, 144, 144),
                    activeColor: const Color.fromARGB(255, 255, 255, 255),


                  ),
                   ),
                  Components.spacerHeight(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("upcoming Events", style: GoogleFonts.robotoCondensed(fontSize: 22,color:controller.isDark.value ? Colors.white : Colors.black ),),
                  ),
                  Components.spacerHeight(15),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 35),
                  //   child: Components.showDividerLine(),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Components.eventListCard(context),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
