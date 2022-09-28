// ignore_for_file: prefer_const_constructors

import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'package:gdsc_app/Controller/app_controller.dart';
import 'package:gdsc_app/Util/App_Constants.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:gdsc_app/Util/dimensions.dart';
import 'package:get/get.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  final controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: controller.isDark.value ? Colors.grey[900] : Colors.white,
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Constants.no_internet, width: 150, height: 150),
                  Components.header_3("Oops", Colors.grey),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Components.header_3('no_internet',
                      controller.isDark.value ? Colors.white : Colors.black87),
                  SizedBox(height: 40),
                  Container(
                      height: 45,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextButton(
                        onPressed: () async {
                          if (await Connectivity().checkConnectivity() !=
                              ConnectivityResult.none) {
                            // Navigator.pushReplacement(
                            //     context, MaterialPageRoute(builder: (_) => child));
                          }
                        },
                        child: Text("Retry"),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
