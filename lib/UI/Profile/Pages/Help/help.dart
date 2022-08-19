import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Util/App_Constants.dart';

class Contact extends StatelessWidget {
  Contact({Key? key}) : super(key: key);
  final controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey[900],
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            iconTheme: const IconThemeData(color: Colors.white, size: 20),
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
                cardColor: const Color.fromARGB(255, 158, 158, 158),
                companyColor: Colors.white,
                taglineColor: Colors.white,
                textColor: Colors.white,
              ),
              SizedBox(height: size.height * 0.01),
              Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Components.header_3(
                    "Feel free to reach out",
                    Colors.white,
                  ),
                  Components.header_3(
                    "Happy Coding",
                    Colors.white,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
