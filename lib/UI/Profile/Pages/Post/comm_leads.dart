import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_app/UI/Notification/pushNotification.dart';
import 'package:gdsc_app/UI/Profile/Pages/Leads/Model/leads_model.dart';
import 'package:gdsc_app/Util/App_Constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Controller/app_controller.dart';
import '../../../../Firebase_Logic/EventFirebase.dart';
import '../../../../Util/App_components.dart';
import '../../../../Util/dimensions.dart';

class CommunityLeads extends StatefulWidget {
  const CommunityLeads({Key? key}) : super(key: key);

  @override
  State<CommunityLeads> createState() => _CommunityLeadsState();
}

class _CommunityLeadsState extends State<CommunityLeads> {
  final controller = Get.put(AppController());
  final name = TextEditingController();
  final role = TextEditingController();
  final phone = TextEditingController();
final email = TextEditingController();
  File? image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          controller.isDark.value ? Colors.grey[900] : Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_SMALL),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                InputField(
                  showRequired: true,
                  title: "Name",
                  hint: "Enter the name of the lead?",
                  controller: name,
                ),
                InputField(
                  showRequired: true,
                  title: "Role",
                  hint: "Enter the role of the lead?",
                  controller: role,
                ),
                Components.spacerHeight(10),
                Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Select image",
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: controller.isDark.value
                      ? Colors.white
                      : Colors.black87,
                )),
            Components.spacerWidth(18),
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.deepOrange,
                    width: 1,
                  ),
                ),
                      child: InkWell(
                        onTap: () async {
                          await controller.getImage();
                      await Components.uploadFile(controller.image.value);
                        },
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          color: controller.isDark.value
                              ? Colors.white
                              : Colors.black87,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                InputField(
                  showRequired: true,
                  title: "Phone",
                  hint: "+254",
                  controller: phone,
                ),
                InputField(
                  showRequired: true,
                  title: "Email",
                  hint: "Enter the email of the lead?",
                  controller: email,
                ),
                Components.spacerHeight(10),
                 notificationCard(
                      iconName: Icons.person,
                      action: "Notify about the lead",
                      widget: Switch(
                          trackColor: MaterialStateProperty.all(
                              controller.isDark.value
                                  ? Colors.white
                                  : Colors.black54),
                          thumbColor:
                              MaterialStateProperty.all(Colors.deepOrange),
                          value: controller.isLeadsEnabled.value,
                          onChanged: ((value) {
                            controller.isLeadsEnabled.value = value;
                            print(value);
                            setState(() {});
                          }))),
                Components.button("Submit", () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  ActionFirebase.createLead(LeadsModel(
                    name.text,
                    role.text,
                    url ?? Constants.defaultIcon,
                    phone.text,
                    email.text

                  ));
                  Get.back();
                  Components.createScaffoldMessanger(
                  "Data sent successfully", context);
                  controller.isLeadsEnabled.value
                  ? FirebaseNotification.sendFirebaseNotification(
                      purpose: "Leads",
                      title: title.text,
                     )
                  : null;
                }, context)
              ],
            )),
      )),
    );
  }
    Widget notificationCard(
      {required IconData iconName,
      required String action,
      required Widget widget}) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.06,
      child: Row(
        children: [
          Row(
            children: [
              Icon(
                iconName,
                size: 18,
                color: controller.isDark.value ? Colors.white : Colors.black87,
              ),
              const SizedBox(width: 15),
              Components.header_3(action,
                  controller.isDark.value ? Colors.white : Colors.black87),
            ],
          ),
          Expanded(child: Container()),
          widget
        ],
      ),
    );
  }

  
}
