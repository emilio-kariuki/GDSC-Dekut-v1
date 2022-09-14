// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:gdsc_app/Firebase_Logic/EventFirebase.dart';
import 'package:gdsc_app/UI/Events/Model/Event_model.dart';
import 'package:gdsc_app/UI/Meetings/Model/meetings_model.dart';
import 'package:gdsc_app/UI/Notification/pushNotification.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_app/Util/App_components.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../Controller/app_controller.dart';
import '../../../../Util/dimensions.dart';

class CommunityMeeting extends StatefulWidget {
  const CommunityMeeting({Key? key}) : super(key: key);

  @override
  State<CommunityMeeting> createState() => _CommunityMeetingState();
}

class _CommunityMeetingState extends State<CommunityMeeting>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.put(AppController());
  final title = TextEditingController();
  final description = TextEditingController();
  final organizers = TextEditingController();
  final link = TextEditingController();
  TimeOfDay time = TimeOfDay.now();
  File? image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          controller.isDark.value ? Colors.grey[900] : Colors.white,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_SMALL),
        child: Column(
          children: [
            InputField(
              showRequired: true,
              title: "Title",
              hint: "Enter the title of the meeting?",
              controller: title,
            ),
            InputField(
              showRequired: true,
              title: "Description",
              hint: "Enter the description of the meeting?",
              controller: description,
              maxLength: 100,
              linesCount: 4,
            ),
            Components.spacerHeight(Dimensions.PADDING_SIZE_SMALL),
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
                      color:
                          controller.isDark.value ? Colors.white : Colors.black87,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            InputField(
              title: "Organizers",
              hint: "Enter the organizers of the event?",
              controller: organizers,
            ),
            InputField(
              showRequired: true,
              title: "Registration Link",
              hint: "Enter the link of the event?",
              controller: link,
            ),
            rowTimeAndEvent(),
            Components.spacerHeight(10),
            Components.spacerHeight(10),
            notificationCard(
                      iconName: Icons.missed_video_call_outlined,
                      action: "Notify about meeting",
                      widget: Switch(
                          trackColor: MaterialStateProperty.all(
                              controller.isDark.value
                                  ? Colors.white
                                  : Colors.black54),
                          thumbColor:
                              MaterialStateProperty.all(Colors.deepOrange),
                          value: controller.isMeetingEnabled.value,
                          onChanged: ((value) {
                            controller.isMeetingEnabled.value = value;
                            print(value);
                            setState(() {});
                          }))),
            Components.button("Submit", () {
              FocusScope.of(context).requestFocus(FocusNode());
              ActionFirebase.createMeeting(MeetingModel(
                  title.text,
                  description.text,
                  controller.selectedDate.value,
                  controller.selectTime.value,
                  link.text,
                  organizers.text,
                  url));
              Get.back();
              Components.createScaffoldMessanger(
                  "Data sent successfully", context);
              controller.isMeetingEnabled.value
                  ? FirebaseNotification.sendFirebaseNotification(
                      purpose: "Meeting",
                      title: title.text,
                     )
                  : null;
            }, context)
          ],
        ),
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

  Widget rowTimeAndEvent() {
    return Row(
      children: [
        Expanded(
          child: InputField(
            showRequired: true,
            title: "Start Time",
            hint: controller.selectTime.value,
            widget: IconButton(
              icon: const Icon(Icons.access_time),
              color: controller.isDark.value ? Colors.white : Colors.black87,
              onPressed: () async {
                String? token = await FirebaseMessaging.instance.getToken();
                print('token: $token');
                FocusScope.of(context).requestFocus(FocusNode());
                final TimeOfDay? result = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          alwaysUse24HourFormat: false,
                        ),
                        child: child!,
                      );
                    });
                if (result != null) {
                  setState(() {
                    time = result;
                    print(
                        "The time schedules to end is : ${controller.selectTime.value}");
                    controller.selectTime.value = result.format(context);
                  });
                }
              },
            ),
          ),
        ),
        Components.spacerWidth(10),
        datePickStart(context)
      ],
    );
  }

  Widget datePickStart(BuildContext context) {
    return GetX<AppController>(
      builder: (controller) {
        return Expanded(
          child: InputField(
            showRequired: true,
            title: "Start Date",
            hint: controller.selectedDate.value,
            widget: IconButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2025),
                ).then((date) {
                  setState(() {
                    controller.selectedDate.value =
                        DateFormat.yMMMd().format(date ?? DateTime.now());
                  });
                });
              },
              icon: Icon(
                Icons.calendar_month_outlined,
                size: 18,
                color: controller.isDark.value ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }

  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
