import 'package:flutter/material.dart';
import 'package:gdsc_app/UI/Authentication/Login/login_page.dart';
import 'package:gdsc_app/UI/Authentication/user_logic.dart';
import 'package:gdsc_app/Util/App_Constants.dart';
import 'package:gdsc_app/main.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Util/App_components.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Components.personalInformation()),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: introTitle(Constants.APP_NAME),
              ),
              Components.showDividerLine(),
              Components.cardButton(Icons.badge, "Details", () => null),
              Components.showDividerLine(),
              Components.cardButton(
                  Icons.shopping_cart_checkout, "Orders", () => null),
              Components.showDividerLine(),
              Components.cardButton(
                  Icons.delivery_dining, "Delivery Address", () => null),
              Components.showDividerLine(),
              Components.cardButton(Icons.person, "Google Leads", () => null),
              Components.showDividerLine(),
              Components.cardButton(
                  Icons.notifications_active, "Notifications", () => null),
              Components.showDividerLine(),
              Components.cardButton(
                  Icons.info_outline_rounded, "About", () => null),
              Components.showDividerLine(),
              Components.cardButton(
                  Icons.help_outline_sharp, "Help", () => null),
              showButton("Log Out", () async {
                await Authentication.signOut();
                Get.offAll(() => const Login());
              })
            ],
          ),
        ),
      ),
    ));
  }


  Widget introTitle(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.quicksand(
          fontSize: 18,
          color: const Color.fromARGB(255, 24, 23, 37),
          fontWeight: FontWeight.w600),
    );
  }



  Widget showTexts(String text) {
    return Text(
      text,
      style: GoogleFonts.quicksand(
          fontSize: 16,
          color: Colors.black38,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.001),
    );
  }


  Widget showButton(String text, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(1),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              Theme.of(context).primaryColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                Text(text,
                    style: GoogleFonts.quicksand(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
