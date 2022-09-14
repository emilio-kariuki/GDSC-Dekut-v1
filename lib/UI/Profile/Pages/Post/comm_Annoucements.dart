import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_app/UI/Notification/pushNotification.dart';
import 'package:gdsc_app/Util/App_Constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Controller/app_controller.dart';
import '../../../../Firebase_Logic/EventFirebase.dart';
import '../../../../Util/App_components.dart';
import '../../../../Util/dimensions.dart';
import '../../../Announcement/Model/announcement_model.dart';
import '../../../Events/Model/Event_model.dart';

class CommunityAnnoucements extends StatefulWidget {
  const CommunityAnnoucements({Key? key}) : super(key: key);

  @override
  State<CommunityAnnoucements> createState() => _CommunityAnnoucementsState();
}

class _CommunityAnnoucementsState extends State<CommunityAnnoucements> {
  final controller = Get.put(AppController());
  final title = TextEditingController();
  final description = TextEditingController();
  File? image;
  final picker = ImagePicker();

  List<String> items = [
    "news",
    "group",
  ];

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
                  title: "Title",
                  hint: "Enter the title of the announcement?",
                  controller: title,
                ),
                InputField(
                  showRequired: false,
                  title: "Link",
                  hint: "Enter the link of the annoucement?",
                  controller: link,
                ),
                InputField(
                  showRequired: true,
                  title: "Description",
                  hint: "Enter the description of the annoucement?",
                  controller: description,
                  maxLength: 80,
                  linesCount: 3,
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
                Components.spacerHeight(10),
                notificationCard(
                    iconName: Icons.notifications_active,
                    action: "Notify about announcement",
                    widget: Switch(
                        trackColor: MaterialStateProperty.all(
                            controller.isDark.value
                                ? Colors.white
                                : Colors.black54),
                        thumbColor:
                            MaterialStateProperty.all(Colors.deepOrange),
                        value: controller.isAnnouncementEnabled.value,
                        onChanged: ((value) {
                          controller.isAnnouncementEnabled.value = value;
                          print(value);
                          setState(() {});
                        }))),
                Components.spacerHeight(10),
                newsDown(),
                Components.button("Submit", () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  controller.selectedCategory.value == "news"
                      ? ActionFirebase.createNews(AnnouncementModel(
                          title.text,
                          description.text,
                          link.text,
                          url,
                        ))
                      : ActionFirebase.createAnnouncement(AnnouncementModel(
                          title.text,
                          description.text,
                          link.text,
                          url,
                        ));
                  Get.back();
                  Components.createScaffoldMessanger(
                      "Data sent successfully", context);
                  controller.isAnnouncementEnabled.value
                      ? FirebaseNotification.sendFirebaseNotification(
                          purpose: "Announcement",
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

  Widget newsDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Category",
            style: GoogleFonts.quicksand(
                fontSize: 16,
                color: controller.isDark.value ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.001),
          ),
          DropdownButton2(
            style: GoogleFonts.quicksand(
              color: controller.isDark.value ? Colors.white : Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            scrollbarAlwaysShow: true,
            dropdownMaxHeight: MediaQuery.of(context).size.height * 0.3,
            hint: Components.header_2("Select one"),
            buttonWidth: MediaQuery.of(context).size.width,
            dropdownDecoration:
                BoxDecoration(color: controller.isDark.value ? Colors.grey[900] : Colors.white),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Components.header_2(item),
                    ))
                .toList(),
            value: controller.selectedCategory.value,
            onChanged: (value) =>
                controller.selectedCategory.value = value.toString(),
          )
        ],
      ),
    );
  }
}
