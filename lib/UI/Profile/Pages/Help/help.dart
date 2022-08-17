import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Util/App_Constants.dart';

class Conntact extends StatelessWidget {
  Conntact({Key? key}) : super(key: key);
  final controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: controller.isDark.value ? Colors.grey[900] : Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: Text("Contact",
                style: GoogleFonts.redressed(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w500))),
        backgroundColor: const Color.fromARGB(255, 7, 9, 15),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.03),
              ContactUs(
                logo: AssetImage(Constants.profile),
                email: 'emilio113kariuki@gmail.com',
                companyName: 'Emilio kariuki',
                phoneNumber: '+254 796 250 443',
                dividerThickness: 1,
                companyFontSize: 30,
                website: "https://linktr.ee/emiliokariuki",
                githubUserName: 'emilio-kariuki',
                linkedinURL: 'https://www.linkedin.com/in/emilio-kariuki/',
                tagLine: 'Flutter Developer',
                twitterHandle: 'EG_Kariuki',
                cardColor: controller.isDark.value ? const Color.fromARGB(255, 158, 158, 158) : const Color.fromARGB(255, 16, 15, 15),
                companyColor: controller.isDark.value ?Colors.black87 : Colors.white,
                taglineColor: controller.isDark.value ?Colors.black87 : Colors.white,
                textColor: controller.isDark.value ?Colors.black87 : Colors.white,
              ),
              SizedBox(height: size.height * 0.01),
              Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Components.header_3("Feel free to reach out", controller.isDark.value ? Colors.white : Colors.black87,),
                      Components.header_3("Happy Coding", controller.isDark.value ? Colors.white : Colors.black87,),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
