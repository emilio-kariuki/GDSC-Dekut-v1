import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_app/UI/Notification/pushNotification.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Controller/app_controller.dart';
import '../../../../Firebase_Logic/EventFirebase.dart';
import '../../../../Util/App_components.dart';
import '../../../../Util/dimensions.dart';
import '../../../Announcement/Model/announcement_model.dart';
import '../../../Resources/Model/resources_model.dart';

class CommunityResources extends StatefulWidget {
  const CommunityResources({Key? key}) : super(key: key);

  @override
  State<CommunityResources> createState() => _CommunityResourcesState();
}

class _CommunityResourcesState extends State<CommunityResources> {
  final controller = Get.put(AppController());
  final title = TextEditingController();
  final description = TextEditingController();
  final link = TextEditingController();
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
                  title: "Title",
                  hint: "Enter the title of the resource?",
                  controller: title,
                ),
                InputField(
                  showRequired: true,
                  title: "Link",
                  hint: "Enter the link of the resource",
                  controller: link,
                ),
                InputField(
                  showRequired: true,
                  title: "Description",
                  hint: "Enter the description of the resource?",
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
                    iconName: Icons.layers,
                    action: "Notify about Resource",
                    widget: Switch(
                        trackColor: MaterialStateProperty.all(
                            controller.isDark.value
                                ? Colors.white
                                : Colors.black54),
                        thumbColor:
                            MaterialStateProperty.all(Colors.deepOrange),
                        value: controller.isResourceEnabled.value,
                        onChanged: ((value) {
                          controller.isResourceEnabled.value = value;
                          print(value);
                          setState(() {});
                        }))),
                Components.button("Submit", () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  ActionFirebase.createResource(ResourceModel(
                    title.text,
                    description.text,
                    url,
                    link.text,
                  ));
                  Get.back();
                  Components.createScaffoldMessanger(
                      "Data sent successfully", context);
                  controller.isResourceEnabled.value
                      ? FirebaseNotification.sendFirebaseNotification(
                          purpose: "Resource",
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
